import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/medic/medical_directory_cubit.dart';
import 'package:anthealth_mobile/blocs/medic/medical_directory_state.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalDirectoryPage extends StatelessWidget {
  const MedicalDirectoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<MedicalDirectoryCubit>(
      create: (context) => MedicalDirectoryCubit(),
      child: BlocBuilder<MedicalDirectoryCubit, CubitState>(
          builder: (context, state) {
        if (state is MedicalDirectoryState) {
          return TemplateFormPage(
              title: S.of(context).Medical_directory,
              back: () => Navigator.of(context).pop(),
              content: buildContent(context, state));
        } else
          return LoadingPage();
      }));

  Widget buildContent(BuildContext context, MedicalDirectoryState state) =>
      Column(children: [
        CommonTextField.select(
            value: null,
            labelText: "City",
            data: state.locationNameList,
            onChanged: (value) {})
      ]);
}
