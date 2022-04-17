import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/medic/medicine_box_cubit.dart';
import 'package:anthealth_mobile/blocs/medic/medicine_box_state.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/box_medicine_logic.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:anthealth_mobile/views/medic/medicine_box/widgets/chose_member_popup.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicineBoxAddPage extends StatelessWidget {
  const MedicineBoxAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MedicineBoxCubit>(
        create: (context) => MedicineBoxCubit(),
        child: BlocBuilder<MedicineBoxCubit, CubitState>(
            builder: (context, state) {
          if (state is MedicineBoxState)
            return TemplateFormPage(
                title: S.of(context).Add_medicine_box,
                back: () => back(context),
                content: buildContent(context, state));
          else
            return LoadingPage();
        }));
  }

  // Content
  Widget buildContent(BuildContext context, MedicineBoxState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CommonTextField.fill(
          context: context,
          onChanged: (String value) => editName(context, state, value),
          labelText: S.of(context).Medicine_box_name,
          hintText: S.of(context).Hint_medicine_box),
      SizedBox(height: 32),
      buildAddMember(context, state),
      SizedBox(height: 32),
      CommonButton.round(context, () {}, S.of(context).Done_medicine_box,
          AnthealthColors.primary1)
    ]);
  }

  // Content Component
  Widget buildAddMember(BuildContext context, MedicineBoxState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CommonText.section(S.of(context).Member, context),
        GestureDetector(
          onTap: () => addMemberTap(context, state),
          child: CommonText.tapTextImage(
              context,
              "assets/app_icon/small_icons/add_member_pri1.png",
              S.of(context).Add_member,
              AnthealthColors.primary1),
        )
      ]),
      if (!BoxMedicineLogic.isNoMember(state.member)) SizedBox(height: 20),
      if (!BoxMedicineLogic.isNoMember(state.member))
        Wrap(
            runSpacing: 16,
            spacing: 16,
            children: BoxMedicineLogic.filterChosenPerson(state.member)
                .map((member) => buildMemberComponent(context, member))
                .toList())
    ]);
  }

  // Child Component
  Container buildMemberComponent(
      BuildContext context, MedicineBoxPerson member) {
    final double width = MediaQuery.of(context).size.width - 32;
    final int count = width ~/ 90;
    final double size = (width - (count - 1) * 16) / count;
    return Container(
        width: size,
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(size),
            child: Image.network(member.avatarPath,
                width: size * 0.7, height: size * 0.7, fit: BoxFit.cover),
          ),
          SizedBox(height: 8),
          Text(member.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1)
        ]));
  }

  // Editing Function
  void editName(BuildContext context, MedicineBoxState state, String value) {
    BlocProvider.of<MedicineBoxCubit>(context).updateData(state, 0, value);
  }

  // Actions
  void back(BuildContext context) {
    Navigator.of(context).pop();
  }

  void addMemberTap(BuildContext context, MedicineBoxState state) {
    showDialog(
        context: context,
        builder: (_) => ChoseMemberPopup(
              personList: state.member,
              done: (result) {
                BlocProvider.of<MedicineBoxCubit>(context)
                    .updateData(state, 1, result);
              },
            ));
  }
}
