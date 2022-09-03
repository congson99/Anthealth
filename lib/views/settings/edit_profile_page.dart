import 'package:anthealth_mobile/blocs/app_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_snackbar.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  String _errorSex = 'null';
  var _nameController = TextEditingController();
  var _phoneController = TextEditingController();
  var _yearController = TextEditingController();
  var _sexController = TextEditingController();
  var _nameFocus = FocusNode();
  var _phoneFocus = FocusNode();
  var _yearFocus = FocusNode();
  var _sexFocus = FocusNode();

  @override
  void initState() {
    _nameController.text = widget.user.name;
    _phoneController.text = widget.user.phoneNumber;
    _yearController.text = widget.user.yOB.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _sexController.text = (widget.user.sex == -1)
        ? ""
        : ((widget.user.sex == 1) ? S.of(context).Male : S.of(context).Female);
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
      CommonTextField.round(
          onChanged: (value) {},
          readOnly: true,
          context: context,
          textInputAction: TextInputAction.done,
          focusNode: _sexFocus,
          textEditingController: _sexController,
          errorText: (_errorSex == "null") ? null : _errorSex,
          labelText: S.of(context).Sex),
      SizedBox(height: 24),
      CommonButton.round(context, () => update(context),
          S.of(context).button_done, AnthealthColors.primary1)
    ]));
  }

  void update(BuildContext context) {
    if (!checkName()) return;
    if (!checkPhone()) return;
    if (!checkYOB()) return;
    BlocProvider.of<AppCubit>(widget.appContext)
        .updateProfile(
            User("", _nameController.text, "", _phoneController.text, "", false,
                int.parse(_yearController.text), widget.user.sex),
            context)
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
}
