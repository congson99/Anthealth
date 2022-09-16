import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/views/common_widgets/avatar.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFamilyMemberPopup extends StatefulWidget {
  const AddFamilyMemberPopup(
      {Key? key, required this.dashboardContext, required this.done})
      : super(key: key);

  final BuildContext dashboardContext;
  final Function(String) done;

  @override
  State<AddFamilyMemberPopup> createState() => _AddFamilyMemberPopupState();
}

class _AddFamilyMemberPopupState extends State<AddFamilyMemberPopup> {
  String email = "";
  List<FamilyMemberData> members = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: EdgeInsets.symmetric(horizontal: 16),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildTitle(context),
                  Expanded(child: buildContent(context)),
                  Divider(height: 1, color: AnthealthColors.black3),
                  buildButton(context)
                ])));
  }

  /// Main Component
  Widget buildTitle(BuildContext context) {
    return Column(children: [
      SizedBox(height: 8),
      Text(S.of(context).Add_member,
          style: Theme.of(context).textTheme.subtitle1),
      SizedBox(height: 8),
      Divider(height: 1, color: AnthealthColors.black3)
    ]);
  }

  Widget buildContent(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CommonTextField.box(
              context: context,
              autofocus: true,
              maxLines: 1,
              hintText: "Email",
              onChanged: (String email) async =>
                  await BlocProvider.of<DashboardCubit>(widget.dashboardContext)
                      .findUser(email)
                      .then((value) {
                    setState(() {
                      members = value;
                    });
                  })),
          SizedBox(height: 24),
          SizedBox(
            height: MediaQuery.of(context).size.height - 670,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...members.map((member) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(children: [
                          Avatar(imagePath: member.avatarPath, size: 48),
                          SizedBox(width: 12),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 200,
                            child: Text(member.email,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.subtitle1),
                          ),
                          Expanded(child: Container()),
                          CommonButton.small(
                              context,
                              () => widget.done(member.email),
                              S.of(context).btn_invite,
                              AnthealthColors.secondary1)
                        ]),
                      ))
                ],
              ),
            ),
          )
        ]));
  }

  Widget buildButton(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
            color: Colors.transparent,
            height: 40,
            alignment: Alignment.center,
            child: Text(S.of(context).button_cancel,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: AnthealthColors.warning1))));
  }
}
