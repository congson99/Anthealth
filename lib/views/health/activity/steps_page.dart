import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/health/activity/widgets/activity_add_data_bottom_sheet.dart';
import 'package:anthealth_mobile/views/health/activity/widgets/activity_circle_bar.dart';
import 'package:anthealth_mobile/views/health/activity/widgets/activity_today.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';

class StepsPage extends StatelessWidget {
  const StepsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: S.of(context).Steps,
        back: () => back(context),
        add: () => add(context),
        settings: () => setting(),
        content: buildContent(context));
  }

  // Content
  Widget buildContent(BuildContext context) {
    return Column(children: [
      ActivityCircleBar(
          percent: 67,
          iconPath: "assets/indicators/steps.png",
          colorID: 1,
          value: '4.600',
          subValue: '3.900',
          title: S.of(context).steps,
          subTitle: 'm'),
      SizedBox(height: 32),
      ActivityToday(
          title: "Thành tích hôm nay",
          colorID: 1,
          value: ["58", "4.600", "3.900", "396"],
          unit: ["%", "bước", "m", "calo"],
          content: ["Mục tiêu", "Đã đi", "Quãng đường", "Đã tiêu thụ"]),
      SizedBox(height: 32),
      SectionComponent(title: S.of(context).Detail, colorID: 1)
    ]);
  }

  // Content Component

  // Child Component

  // Actions
  void back(BuildContext context) {
    Navigator.of(context).pop();
  }

  void add(BuildContext context) {
    showModalBottomSheet(
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        context: context,
        builder: (_) => ActivityAddDataBottomSheet(
            title: S.of(context).Add_steps,
            activity: S.of(context).Steps_count,
            dataPicker: ["0", "1"],
            subDataPicker: ["0", "1"],
            indexPicker: 0,
            subIndexPicker: 0,
            dateTime: DateTime.now(),
            unit: S.of(context).steps,
            middleSymbol: '.',
            cancel: () => Navigator.pop(context),
            ok: (indexPicker, subIndexPicker, time) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(S.of(context).Add_steps +
                      ' ' +
                      S.of(context).successfully +
                      '!')));
              Navigator.pop(context);
            }));
  }

  void setting() {}
}
