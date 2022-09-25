import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/models/notification/warning.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/views/health/indicator/blood_pressure_page.dart';
import 'package:anthealth_mobile/views/health/indicator/heart_rate_page.dart';
import 'package:anthealth_mobile/views/health/indicator/spo2_page.dart';
import 'package:anthealth_mobile/views/health/indicator/temperature_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WarningComponent extends StatelessWidget {
  const WarningComponent({
    Key? key,
    required this.context,
    required this.w,
  }) : super(key: key);

  final BuildContext context;
  final Warning w;

  @override
  Widget build(BuildContext context) {
    String subTitle = "";
    switch (w.type) {
      case (2):
        {
          subTitle = w.value.toStringAsFixed(0) + " BPM";
          break;
        }
      case (3):
        {
          subTitle = w.value.toStringAsFixed(0) + " °C";
          break;
        }
      case (4):
        {
          subTitle = w.value.toStringAsFixed(0) + " mmHg";
          break;
        }
      default:
        subTitle = w.value.toStringAsFixed(0) + " %";
    }
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        if (w.type == 2)
          return HeartRatePage(
            dashboardContext: context,
            mem: FamilyMemberData(
                w.uid,
                w.name,
                w.avatar,
                "",
                "",
                false,
                [
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                ],
                -1,
                -1),
            user: User("id", "name", "avatarPath", "phoneNumber", "email",
                false, -1, 0),
          );
        if (w.type == 3)
          return TemperaturePage(
            dashboardContext: context,
            mem: FamilyMemberData(
                w.uid,
                w.name,
                w.avatar,
                "",
                "",
                false,
                [
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                ],
                -1,
                -1),
            user: User("id", "name", "avatarPath", "phoneNumber", "email",
                false, -1, 0),
          );
        if (w.type == 4)
          return BloodPressurePage(
            dashboardContext: context,
            mem: FamilyMemberData(
                w.uid,
                w.name,
                w.avatar,
                "",
                "",
                false,
                [
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                ],
                -1,
                -1),
            user: User("id", "name", "avatarPath", "phoneNumber", "email",
                false, -1, 0),
          );
        return SPO2Page(
          dashboardContext: context,
          mem: FamilyMemberData(
              w.uid,
              w.name,
              w.avatar,
              "",
              "",
              false,
              [
                true,
                true,
                true,
                true,
                true,
                true,
                true,
                true,
                true,
              ],
              -1,
              -1),
          user: User(
              "id", "name", "avatarPath", "phoneNumber", "email", false, -1, 0),
        );
      })),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            color: AnthealthColors.warning4,
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AnthealthColors.warning0),
                  borderRadius: BorderRadius.circular(24)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.network(
                    (w.avatar == "")
                        ? "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"
                        : w.avatar,
                    height: 48.0,
                    width: 48.0,
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(DateFormat("hh:mm dd.MM.yyyy").format(w.time),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: AnthealthColors.warning0, fontSize: 12)),
                SizedBox(height: 2),
                Text(
                  w.notice,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: AnthealthColors.warning0),
                ),
                SizedBox(height: 6),
                Text(
                  subTitle,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: AnthealthColors.warning1),
                ),
              ],
            )),
            SizedBox(width: 8),
            Image.asset("assets/app_icon/direction/right_war1.png",
                height: 16.0, width: 16.0, fit: BoxFit.cover)
          ],
        ),
      ),
    );
  }
}
