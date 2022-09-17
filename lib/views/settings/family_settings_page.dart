import 'package:anthealth_mobile/blocs/app_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_snackbar.dart';
import 'package:anthealth_mobile/views/common_widgets/info_popup.dart';
import 'package:anthealth_mobile/views/common_widgets/yes_no_popup.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FamilySettingsPage extends StatelessWidget {
  const FamilySettingsPage(
      {Key? key, required this.memberData, required this.user})
      : super(key: key);

  final User user;
  final List<FamilyMemberData> memberData;

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: S.of(context).family_settings,
        back: () => Navigator.pop(context),
        content: buildContent(context));
  }

  Widget buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (memberData.length > 1)
          CommonText.section(S.of(context).Permission_setting, context),
        ...memberData.where((element) => element.id != user.id).map((member) =>
            buildMemberPermission(context, member, memberData.indexOf(member))),
        SizedBox(height: 24),
        GestureDetector(
            onTap: () => outFamily(context),
            child: Text(S.of(context).Out_family,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Colors.black54)))
      ],
    );
  }

  Widget buildMemberPermission(
      BuildContext context, FamilyMemberData member, int index) {
    int colorID = index ~/ 3;
    Color color0 = colorID == 0
        ? AnthealthColors.primary0
        : colorID == 1
            ? AnthealthColors.secondary0
            : colorID == 2
                ? AnthealthColors.warning0
                : AnthealthColors.black0;
    Color color5 = colorID == 0
        ? AnthealthColors.primary5
        : colorID == 1
            ? AnthealthColors.secondary5
            : colorID == 2
                ? AnthealthColors.warning5
                : AnthealthColors.black5;
    return GestureDetector(
      onTap: () => buildAddIndicatorBottomSheet(member, context),
      child: Container(
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: color5,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                  (member.avatarPath == "")
                      ? "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"
                      : member.avatarPath,
                  height: 40.0,
                  width: 40.0,
                  fit: BoxFit.cover),
            ),
            SizedBox(width: 10),
            Text(member.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: color0)),
            Spacer(),
            Image.asset(
                colorID == 0
                    ? "assets/app_icon/direction/right_pri1.png"
                    : colorID == 1
                        ? "assets/app_icon/direction/right_sec1.png"
                        : colorID == 2
                            ? "assets/app_icon/direction/right_war1.png"
                            : "assets/app_icon/direction/right_bla2.png",
                height: 16.0,
                width: 16.0,
                fit: BoxFit.cover)
          ])),
    );
  }

  void outFamily(BuildContext context) {
    bool isAdmin = false;
    for (FamilyMemberData x in memberData)
      if (user.id == x.id) isAdmin = x.admin;
    if (isAdmin)
      showDialog(
          context: context,
          builder: (_) => InfoPopup(
              title: S.of(context).can_not_out,
              ok: () => Navigator.pop(context)));
    else
      showDialog(
          context: context,
          builder: (_) => YesNoPopup(
              title: S.of(context).Out_family,
              no: () => Navigator.pop(context),
              yes: () async {
                Navigator.pop(context);
                await BlocProvider.of<AppCubit>(context)
                    .outFamily()
                    .then((value) {
                  if (value) {
                    ShowSnackBar.showSuccessSnackBar(context,
                        "${S.of(context).Out_family} ${S.of(context).successfully}");
                    Navigator.pop(context);
                  } else {
                    ShowSnackBar.showErrorSnackBar(
                        context, S.of(context).something_wrong);
                  }
                });
              }));
  }

  Future<dynamic> buildAddIndicatorBottomSheet(
      FamilyMemberData member, BuildContext context) {
    return showModalBottomSheet(
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        context: context,
        builder: (_) => PermissionUpdateBottomSheet(
              member: member,
              result: (result) {
                BlocProvider.of<AppCubit>(context)
                    .updatePermission(member.id, result)
                    .then((value) {
                  if (value) {
                    ShowSnackBar.showSuccessSnackBar(
                        context, S.of(context).successfully);
                  } else
                    ShowSnackBar.showErrorSnackBar(
                        context, S.of(context).something_wrong);
                });
              },
            ));
  }
}

class PermissionUpdateBottomSheet extends StatefulWidget {
  const PermissionUpdateBottomSheet(
      {Key? key, required this.member, required this.result})
      : super(key: key);

  final FamilyMemberData member;
  final Function(List<bool>) result;

  @override
  State<PermissionUpdateBottomSheet> createState() =>
      _PermissionUpdateBottomSheetState();
}

class _PermissionUpdateBottomSheetState
    extends State<PermissionUpdateBottomSheet> {
  List<bool> permission = [];

  @override
  Widget build(BuildContext context) {
    permission = widget.member.permission;
    return SafeArea(
        child: Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16),
            Column(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                    (widget.member.avatarPath == "")
                        ? "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"
                        : widget.member.avatarPath,
                    height: 60.0,
                    width: 60.0,
                    fit: BoxFit.cover),
              ),
              SizedBox(height: 10),
              Text(widget.member.name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: AnthealthColors.black0)),
            ]),
            buildPermissionComponent(context, 0,
                "assets/app_icon/attach/height.png", S.of(context).Height, 0),
            buildPermissionComponent(context, 1,
                "assets/app_icon/attach/weight.png", S.of(context).Height, 1),
            buildPermissionComponent(
                context,
                2,
                "assets/app_icon/attach/heart_rate.png",
                S.of(context).Heart_rate,
                2),
            buildPermissionComponent(context, 0,
                "assets/app_icon/attach/spo2.png", S.of(context).Spo2, 5),
            buildPermissionComponent(
                context,
                1,
                "assets/app_icon/attach/temperature.png",
                S.of(context).Temperature,
                3),
            buildPermissionComponent(
                context,
                2,
                "assets/app_icon/attach/blood_pressure.png",
                S.of(context).Blood_pressure,
                4),
            buildPermissionComponent(
                context,
                0,
                "assets/app_icon/attach/water.png",
                S.of(context).Drink_water,
                7),
            buildPermissionComponent(context, 2,
                "assets/app_icon/attach/calo.png", S.of(context).Calo, 6),
            buildPermissionComponent(
                context,
                0,
                "assets/app_icon/attach/medical_record.png",
                S.of(context).Medical_record,
                8),
            SizedBox(height: 24),
            CommonButton.round(context, () {
              Navigator.pop(context);
              widget.result(permission);
            }, S.of(context).Update, AnthealthColors.primary1),
            SizedBox(height: 16),
          ],
        ),
      ),
    ));
  }

  Widget buildPermissionComponent(BuildContext context, int colorID,
      String iconPath, String content, int id) {
    Color color0 = colorID == 0
        ? AnthealthColors.primary0
        : colorID == 1
            ? AnthealthColors.secondary0
            : colorID == 2
                ? AnthealthColors.warning0
                : AnthealthColors.black0;
    Color color3 = colorID == 0
        ? AnthealthColors.primary3
        : colorID == 1
            ? AnthealthColors.secondary3
            : colorID == 2
                ? AnthealthColors.warning3
                : AnthealthColors.black3;
    Color color5 = colorID == 0
        ? AnthealthColors.primary5
        : colorID == 1
            ? AnthealthColors.secondary5
            : colorID == 2
                ? AnthealthColors.warning5
                : AnthealthColors.black5;
    return Container(
        margin: EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          color: (permission[id]) ? color5 : AnthealthColors.black5,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(children: [
          if (permission[id])
            Image.asset(iconPath, height: 24.0, width: 24, fit: BoxFit.contain),
          if (permission[id]) SizedBox(width: 10),
          Text(content,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: (permission[id]) ? color0 : AnthealthColors.black0)),
          Spacer(),
          GestureDetector(
              onTap: () {
                setState(() {
                  permission[id] = !permission[id];
                });
              },
              child: buildSwitch(permission[id], color3, color0))
        ]));
  }

  Widget buildSwitch(bool accept, Color color3, Color color0) {
    if (accept)
      return Container(
        height: 26,
        width: 42,
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color3,
            ),
            BoxShadow(
              color: Colors.white,
              spreadRadius: -2,
              blurRadius: 2.0,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
        child: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: color0),
        ),
      );
    return Container(
      height: 26,
      width: 42,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AnthealthColors.black4,
          ),
          BoxShadow(
            color: Colors.white,
            spreadRadius: -1,
            blurRadius: 1.0,
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AnthealthColors.black3),
      ),
    );
  }
}
