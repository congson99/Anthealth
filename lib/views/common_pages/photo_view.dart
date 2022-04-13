import 'dart:io';

import 'package:anthealth_mobile/blocs/medic/medical_record_detail_cubit.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_detail_state.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_appbar.dart';
import 'package:anthealth_mobile/views/common_widgets/warning_popup.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoView extends StatelessWidget {
  const PhotoView(
      {Key? key,
      required this.photo,
      this.isDelete,
      required this.superContext,
      required this.state,
      required this.photoIndex,
      required this.index})
      : super(key: key);

  final File photo;
  final bool? isDelete;
  final BuildContext superContext;
  final MedicalRecordDetailState state;
  final int photoIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      buildContent(context),
      CustomAppBar(
          title: S.of(context).Photo_view, back: () => Navigator.pop(context))
    ])));
  }

  Widget buildContent(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 57),
          Expanded(
              child: InteractiveViewer(
                  child: Image.file(photo, fit: BoxFit.contain))),
          SizedBox(height: 16),
          if (isDelete != false)
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CommonButton.round(
                    context,
                    () => showDialog(
                        context: context,
                        builder: (_) => WarningPopup(
                            title: S.of(context).Warning_delete_photo,
                            cancel: () => Navigator.pop(context),
                            delete: () {
                              List<List<File>> temp = state.list;
                              temp[index].removeAt(photoIndex);
                              BlocProvider.of<MedicalRecordDetailCubit>(
                                      superContext)
                                  .updateData(state.data, "", "", temp);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            })),
                    S.of(context).Delete_photo,
                    AnthealthColors.warning1)),
          if (isDelete != false) SizedBox(height: 32),
        ]);
  }
}
