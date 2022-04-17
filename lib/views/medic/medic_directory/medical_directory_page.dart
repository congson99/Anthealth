import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/medic/medical_directory_cubit.dart';
import 'package:anthealth_mobile/blocs/medic/medical_directory_state.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/midical_directory_logic.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/medic/medic_directory/medical_contact_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
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
              settings: () {},
              content: buildContent(context, state));
        } else
          return LoadingPage();
      }));

  // Content
  Widget buildContent(BuildContext context, MedicalDirectoryState state) =>
      Column(children: [
        Row(children: [
          Image.asset("assets/app_icon/common/location_pri1.png",
              height: 16, fit: BoxFit.fitHeight),
          Text("  " + state.location,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: AnthealthColors.primary0))
        ]),
        Column(
            children: MedicalDirectoryLogic.formatToMaskList(state.data)
                .map((mask) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => MedicalContactPage(
                              contact: state.data[mask.index])));
                    },
                    child: buildContact(context, mask)))
                .toList())
      ]);

  Widget buildContact(
          BuildContext context, MedicalDirectoryAlphabetMarkData mask) =>
      Container(
          color: Colors.transparent,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (mask.getMark())
              Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 10),
                  child: Text(mask.getName().substring(0, 1).toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: AnthealthColors.black2))),
            if (mask.getMark()) CustomDivider.common(),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(mask.getName(),
                    style: Theme.of(context).textTheme.headline6)),
            CustomDivider.common()
          ]));
}
