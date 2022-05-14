import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/community/post_models.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/views/health/activity/calo_page.dart';
import 'package:anthealth_mobile/views/health/activity/steps_page.dart';
import 'package:anthealth_mobile/views/health/activity/water_page.dart';
import 'package:anthealth_mobile/views/health/indicator/blood_pressure_page.dart';
import 'package:anthealth_mobile/views/health/indicator/heart_rate_page.dart';
import 'package:anthealth_mobile/views/health/indicator/height_page.dart';
import 'package:anthealth_mobile/views/health/indicator/spo2_page.dart';
import 'package:anthealth_mobile/views/health/indicator/temperature_page.dart';
import 'package:anthealth_mobile/views/health/indicator/weight_page.dart';
import 'package:anthealth_mobile/views/medic/medical_record/medical_record_detail_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/user/user_profile_page.dart';
import 'package:flutter/material.dart';

class AttachComponent extends StatelessWidget {
  const AttachComponent({
    Key? key,
    required this.attach,
  }) : super(key: key);

  final Attach attach;

  @override
  Widget build(BuildContext context) {
    return buildSectionComponent(context);
  }

  Widget buildSectionComponent(BuildContext context) {
    if (attach.type <= 10)
      return AttachSectionComponent(
          onTap: () => getOnTap(context),
          iconPath: getSectionComponentImagePath(),
          title: getSectionComponentTitle(context),
          subTitle: attach.ownerName,
          subSubTitle:
              (attach.dataDescription != "") ? attach.dataDescription : null,
          colorID: getSectionComponentColorId());
    else
      return AttachUserComponent(
          name: attach.ownerName,
          avatarPath: attach.ownerAvatar,
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => UserProfilePage(
                  user: User(attach.ownerID, attach.ownerName,
                      attach.ownerAvatar, "phoneNumber", "email")))));
  }

  String getSectionComponentImagePath() {
    switch (attach.type) {
      case 1:
        return "assets/indicators/height.png";
      case 2:
        return "assets/indicators/weight.png";
      case 3:
        return "assets/indicators/heart_rate.png";
      case 4:
        return "assets/indicators/temperature.png";
      case 5:
        return "assets/indicators/blood_pressure.png";
      case 6:
        return "assets/indicators/spo2.png";
      case 7:
        return "assets/indicators/calo.png";
      case 8:
        return "assets/indicators/water.png";
      case 9:
        return "assets/indicators/steps.png";
      case 10:
        return "assets/indicators/medical_record.png";
      default:
        return "";
    }
  }

  String getSectionComponentTitle(BuildContext context) {
    switch (attach.type) {
      case 1:
        return S.of(context).Height;
      case 2:
        return S.of(context).Weight;
      case 3:
        return S.of(context).Heart_rate;
      case 4:
        return S.of(context).Temperature;
      case 5:
        return S.of(context).Blood_pressure;
      case 6:
        return S.of(context).Spo2;
      case 7:
        return S.of(context).Calo;
      case 8:
        return S.of(context).Drink_water;
      case 9:
        return S.of(context).Steps;
      case 10:
        return S.of(context).Medic_record;
      default:
        return "";
    }
  }

  int getSectionComponentColorId() {
    switch (attach.type) {
      case 2:
        return 1;
      case 3:
        return 2;
      case 4:
        return 1;
      case 5:
        return 2;
      case 7:
        return 2;
      case 9:
        return 1;
      default:
        return 0;
    }
  }

  void getOnTap(BuildContext context) {
    FamilyMemberData memberData = FamilyMemberData(
        attach.ownerID,
        attach.ownerName,
        attach.ownerAvatar,
        "",
        "",
        false,
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    switch (attach.type) {
      case 1:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => HeightPage(data: memberData)));
        return;
      case 2:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => WeightPage(data: memberData)));
        return;
      case 3:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => HeartRatePage(data: memberData)));
        return;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => TemperaturePage(data: memberData)));
        return;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => BloodPressurePage(data: memberData)));
        return;
      case 6:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => SPO2Page(data: memberData)));
        return;
      case 7:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => CaloPage(data: memberData)));
        return;
      case 8:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => WaterPage(data: memberData)));
        return;
      case 9:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => StepsPage(data: memberData)));
        return;
      case 10:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => MedicalRecordDetailPage(
                medicalRecordID: attach.dataID, data: memberData)));
        return;
    }
  }
}

class AttachSectionComponent extends StatelessWidget {
  const AttachSectionComponent(
      {Key? key,
      required this.title,
      required this.subTitle,
      this.subSubTitle,
      this.iconPath,
      required this.colorID,
      this.onTap})
      : super(key: key);

  final String title;
  final String subTitle;
  final String? subSubTitle;
  final String? iconPath;
  final int colorID;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color color0 = colorID == 0
        ? AnthealthColors.primary0
        : colorID == 1
            ? AnthealthColors.secondary0
            : colorID == 2
                ? AnthealthColors.warning0
                : AnthealthColors.black0;
    Color color1 = colorID == 0
        ? AnthealthColors.primary1
        : colorID == 1
            ? AnthealthColors.secondary1
            : colorID == 2
                ? AnthealthColors.warning1
                : AnthealthColors.black1;
    Color color5 = colorID == 0
        ? AnthealthColors.primary5
        : colorID == 1
            ? AnthealthColors.secondary5
            : colorID == 2
                ? AnthealthColors.warning5
                : AnthealthColors.black5;
    return GestureDetector(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
                color: color5, borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: buildContent(context, color0, color1)));
  }

  Widget buildContent(BuildContext context, Color color0, Color color1) {
    return Row(children: [
      Image.asset(iconPath!, height: 45.0, fit: BoxFit.cover),
      SizedBox(width: 12),
      buildTitles(context, color0, color1)
    ]);
  }

  Widget buildTitles(BuildContext context, Color color0, Color color1) =>
      Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: color0)),
            SizedBox(height: 4),
            Text(subTitle,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: color1)),
            if (subSubTitle != null) SizedBox(height: 4),
            if (subSubTitle != null)
              Text(subSubTitle ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: color1))
          ]));
}

class AttachUserComponent extends StatelessWidget {
  const AttachUserComponent(
      {Key? key,
      required this.name,
      this.description,
      required this.avatarPath,
      this.onTap})
      : super(key: key);

  final String name;
  final String? description;
  final String avatarPath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AnthealthColors.black2)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: buildContent(context)));
  }

  Widget buildContent(BuildContext context) {
    return Row(children: [
      CircleAvatar(backgroundImage: NetworkImage(avatarPath)),
      SizedBox(width: 12),
      buildTitles(context)
    ]);
  }

  Widget buildTitles(BuildContext context) => Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(description ?? S.of(context).Profile,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption),
            Text(name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AnthealthColors.black0))
          ]));
}
