import 'dart:io';

import 'package:anthealth_mobile/blocs/medic/medical_record_detail_cubit.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_detail_state.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_appbar.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddPhotoView extends StatefulWidget {
  const AddPhotoView(
      {Key? key,
      required this.superContext,
      required this.state,
      required this.index})
      : super(key: key);

  final BuildContext superContext;
  final MedicalRecordDetailState state;
  final int index;

  @override
  State<AddPhotoView> createState() => _AddPhotoViewState();
}

class _AddPhotoViewState extends State<AddPhotoView> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      buildContent(),
      CustomAppBar(
          title: S.of(context).Add_photo, back: () => Navigator.pop(context))
    ])));
  }

  Widget buildContent() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 78),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonButton.photo(
                        context,
                        () => pickImage(ImageSource.gallery),
                        S.of(context).Pick_gallery,
                        "assets/app_icon/small_icons/gallery.png",
                        AnthealthColors.black1),
                    SizedBox(width: 12),
                    CommonButton.photo(
                        context,
                        () => pickImage(ImageSource.camera),
                        S.of(context).Pick_camera,
                        "assets/app_icon/small_icons/camera.png",
                        AnthealthColors.black1)
                  ]),
              SizedBox(height: 16),
              Container(
                  height: MediaQuery.of(context).size.width,
                  color: AnthealthColors.black4,
                  alignment: Alignment.center,
                  child: (image != null)
                      ? Image.file(image!)
                      : Image.asset("assets/app_icon/small_icons/gallery.png",
                          height: 80, fit: BoxFit.contain)),
              SizedBox(height: 32),
              if (image != null)
                CommonButton.round(context, () {
                  List<List<File>> temp = widget.state.list;
                  if (image != null) temp[widget.index].add(image!);
                  BlocProvider.of<MedicalRecordDetailCubit>(widget.superContext)
                      .updateData(widget.state.data, "", "", temp);
                  Navigator.pop(context);
                }, S.of(context).Add_photo, AnthealthColors.secondary1)
            ]));
  }

  Future pickImage(ImageSource imageSource) async {
    try {
      final mImage = await ImagePicker().pickImage(source: imageSource);
      if (mImage == null) return;
      setState(() {
        this.image = File(mImage.path);
      });
      print(mImage.name);
    } on PlatformException catch (e) {
      print("Failed to pick Image: $e");
    }
  }
}
