import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/medic/medicine_box_cubit.dart';
import 'package:anthealth_mobile/blocs/medic/medicine_box_state.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/box_medicine_logic.dart';
import 'package:anthealth_mobile/logics/medicine_logic.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/avatar.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/medic/medicine_box/medicine_box_edit_page.dart';
import 'package:anthealth_mobile/views/medic/medicine_box/widgets/add_medicine_popup.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicineBoxPage extends StatelessWidget {
  const MedicineBoxPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MedicineBoxCubit>(
        create: (context) => MedicineBoxCubit(id),
        child: BlocBuilder<MedicineBoxCubit, CubitState>(
            builder: (context, state) {
          if (state is MedicineBoxState)
            return TemplateFormPage(
                title: state.name,
                back: () => back(context),
                edit: () => edit(context, state),
                content: buildContent(context, state));
          else
            return LoadingPage();
        }));
  }

  // Content
  Widget buildContent(BuildContext context, MedicineBoxState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      buildMedicine(context, state),
      SizedBox(height: 16),
      CustomDivider.common(),
      SizedBox(height: 16),
      buildMember(context, state),
    ]);
  }

  // Content Component
  Widget buildMedicine(BuildContext context, MedicineBoxState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CommonText.section(S.of(context).Medicine_list, context),
        GestureDetector(
            onTap: () => addMedicineTap(context, state),
            child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonText.tapTextImage(
                    context,
                    "assets/app_icon/small_icons/add_medicine_sec1.png",
                    S.of(context).Add_medicine,
                    AnthealthColors.secondary1)))
      ]),
      SizedBox(height: 16),
      if (state.medicine.length == 0)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(S.of(context).no_medicine_in_box),
        ),
      if (state.medicine.length != 0)
        Column(
            children: state.medicine
                .map((medicine) => buildMedicineComponent(
                    context, state, medicine, state.medicine.indexOf(medicine)))
                .toList())
    ]);
  }

  Widget buildMember(BuildContext context, MedicineBoxState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CommonText.section(S.of(context).Member, context),
      SizedBox(height: 20),
      Wrap(
          runSpacing: 16,
          spacing: 16,
          children: BoxMedicineLogic.filterChosenPerson(state.member)
              .map((member) => buildMemberComponent(context, member))
              .toList())
    ]);
  }

  // Child Component
  Widget buildMedicineComponent(BuildContext context, MedicineBoxState state,
      MedicineData medicine, int index) {
    return GestureDetector(
        onTap: () => editMedicineTap(context, state, index, medicine),
        child: Container(
            decoration: BoxDecoration(
                color: AnthealthColors.secondary5,
                borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(children: [
              Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AnthealthColors.secondary3, width: 1)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.network(medicine.getImagePath(),
                          height: 70.0, width: 70.0, fit: BoxFit.cover))),
              SizedBox(width: 8),
              Container(
                  width: MediaQuery.of(context).size.width - 64 - 56 - 8,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(children: [
                          Expanded(
                              child: Text(medicine.getName(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                          color: AnthealthColors.secondary0))),
                          Text(
                              MedicineLogic.handleQuantity(
                                      medicine.getQuantity()) +
                                  " " +
                                  MedicineLogic.getUnit(
                                      context, medicine.getUnit()),
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: AnthealthColors.secondary1)),
                        ]),
                        SizedBox(height: 4),
                        Text(
                            MedicineLogic.handleMedicineWithoutDosageString(
                                context, medicine),
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: AnthealthColors.secondary1))
                      ]))
            ])));
  }

  Widget buildMemberComponent(BuildContext context, MedicineBoxPerson member) {
    final double width = MediaQuery.of(context).size.width - 32;
    final int count = width ~/ 90;
    final double size = (width - (count - 1) * 16) / count;
    return Container(
        width: size,
        child: Column(children: [
          Avatar(imagePath: member.avatarPath, size: size * 0.7),
          SizedBox(height: 8),
          Text(member.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1)
        ]));
  }

  // Actions
  void back(BuildContext context) {
    Navigator.of(context).pop();
  }

  void edit(BuildContext context, MedicineBoxState state) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) =>
            MedicineBoxEditPage(superContext: context, state: state)));
  }

  void addMedicineTap(BuildContext context, MedicineBoxState state) {
    List<String> medicineList =
        BlocProvider.of<MedicineBoxCubit>(context).loadMedicineList();
    if (medicineList.length != 0)
      showDialog(
          context: context,
          builder: (_) => AddMedicinePopup(
                superContext: context,
                state: state,
                medicineList: medicineList,
              ));
  }

  void editMedicineTap(BuildContext context, MedicineBoxState state, int index,
      MedicineData data) {
    showDialog(
        context: context,
        builder: (_) => AddMedicinePopup(
              superContext: context,
              state: state,
              index: index,
              data: data,
            ));
  }
}
