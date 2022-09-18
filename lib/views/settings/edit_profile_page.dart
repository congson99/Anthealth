import 'dart:io';

import 'package:anthealth_mobile/blocs/app_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/services/firebase/firebase_service.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_snackbar.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage(
      {Key? key, required this.user, required this.appContext})
      : super(key: key);

  final User user;
  final BuildContext appContext;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String _errorName = 'null';
  String _errorPhone = 'null';
  String _errorYear = 'null';
  var _nameController = TextEditingController();
  var _phoneController = TextEditingController();
  var _yearController = TextEditingController();
  String _sexController = "";
  var _nameFocus = FocusNode();
  var _phoneFocus = FocusNode();
  var _yearFocus = FocusNode();
  var _sexFocus = FocusNode();

  String images = "";

  @override
  void initState() {
    images = (widget.user.avatarPath == "")
        ? "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"
        : widget.user.avatarPath;
    _nameController.text = widget.user.name;
    _phoneController.text = widget.user.phoneNumber;
    _yearController.text =
        (widget.user.yOB == -1) ? "" : widget.user.yOB.toString();
    _sexController =
        (widget.user.sex == -1) ? "" : ((widget.user.sex == 0) ? "Nam" : "Nữ");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
      title: S.of(context).Edit_profile,
      content: buildContent(context),
      back: () => Navigator.pop(context),
    );
  }

  Widget buildContent(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      SizedBox(height: 16),
      GestureDetector(
        onTap: () => onAddPhotoTap(),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(images,
                  height: 100.0, width: 100.0, fit: BoxFit.cover),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/app_icon/common/icon_camera_edit.png",
                width: 32,
                height: 32,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 32),
      CommonTextField.round(
          onChanged: (value) {
            _disappearError();
          },
          context: context,
          textInputAction: TextInputAction.done,
          focusNode: _nameFocus,
          textEditingController: _nameController,
          errorText: (_errorName == "null") ? null : _errorName,
          labelText: S.of(context).Name),
      SizedBox(height: 32),
      CommonTextField.round(
          onChanged: (value) {
            _disappearError();
          },
          context: context,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
          focusNode: _phoneFocus,
          textEditingController: _phoneController,
          errorText: (_errorPhone == "null") ? null : _errorPhone,
          labelText: S.of(context).Phone_number),
      SizedBox(height: 32),
      CommonTextField.round(
          onChanged: (value) {
            _disappearError();
          },
          textInputType: TextInputType.number,
          context: context,
          textInputAction: TextInputAction.done,
          focusNode: _yearFocus,
          textEditingController: _yearController,
          errorText: (_errorYear == "null") ? null : _errorYear,
          labelText: S.of(context).Year_of_birth),
      SizedBox(height: 32),
      CommonTextField.newSelectBox(
          onChanged: (value) {
            setState(() {
              _sexController = value!;
            });
          },
          value: (_sexController == "") ? null : _sexController,
          focusNode: _sexFocus,
          data: ["Nam", "Nữ"]),
      SizedBox(height: 24),
      CommonButton.round(context, () => update(context),
          S.of(context).button_done, AnthealthColors.primary1)
    ]));
  }

  void update(BuildContext context) {
    if (!checkName()) return;
    if (!checkPhone()) return;
    if (!checkYOB()) return;
    int sex = (_sexController == "") ? -1 : ((_sexController == "Nam") ? 0 : 1);
    BlocProvider.of<AppCubit>(widget.appContext)
        .updateProfile(
            User("", _nameController.text, "", _phoneController.text, "", false,
                int.parse(_yearController.text), sex),
            context,
            images)
        .then((value) {
      if (value) {
        Navigator.pop(context);
        Navigator.pop(context);
        BlocProvider.of<AppCubit>(widget.appContext).startApp();
        ShowSnackBar.showSuccessSnackBar(context, "Edit profile successful");
      }
    });
  }

  bool checkName() {
    if (_nameController.text != '') return true;
    setState(() {
      _errorName = S.of(context).Enter_name;
    });
    FocusScope.of(context).requestFocus(_nameFocus);
    return false;
  }

  bool checkPhone() {
    if (_phoneController.text != '' && _phoneController.text.length > 9)
      return true;
    setState(() {
      _errorPhone = S.of(context).Invalid_phone;
    });
    FocusScope.of(context).requestFocus(_phoneFocus);
    return false;
  }

  bool checkYOB() {
    if (_yearController.text != '' &&
        int.parse(_yearController.text) <= DateTime.now().year) return true;
    setState(() {
      _errorYear = S.of(context).Invalid_yob;
    });
    FocusScope.of(context).requestFocus(_yearFocus);
    return false;
  }

  void _disappearError() {
    setState(() {
      _errorName = "null";
      _errorPhone = "null";
      _errorYear = "null";
    });
  }

  Future<dynamic> onAddPhotoTap() {
    return showModalBottomSheet(
        context: context,
        builder: (_) => SafeArea(
            child: SizedBox(
                height: 150,
                child: Column(children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        pickImage(ImageSource.camera);
                      },
                      child: Container(
                          height: 64,
                          color: Colors.transparent,
                          padding: const EdgeInsets.all(16),
                          child: Row(children: [
                            Image.asset(
                                "assets/app_icon/small_icons/camera_bla2.png"),
                            SizedBox(width: 8),
                            Text(S.of(context).Pick_camera,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: AnthealthColors.black2))
                          ]))),
                  CustomDivider.common(),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        pickImage(ImageSource.gallery);
                      },
                      child: Container(
                          height: 64,
                          color: Colors.transparent,
                          padding: const EdgeInsets.all(16),
                          child: Row(children: [
                            Image.asset(
                                "assets/app_icon/small_icons/photo_bla2.png"),
                            SizedBox(width: 8),
                            Text(S.of(context).Pick_gallery,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: AnthealthColors.black2))
                          ])))
                ]))));
  }

  Future pickImage(ImageSource imageSource) async {
    try {
      final mImage = await ImagePicker().pickImage(source: imageSource);
      if (mImage == null) return;
      File imageFile = File(mImage.path);
      var downloadUrl = await FirebaseService.instance.uploadImage(imageFile);
      setState(() {
        images = downloadUrl;
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to pick Image: $e");
    }
  }
}
