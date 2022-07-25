import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class SettingLanguagePage extends StatelessWidget {
  const SettingLanguagePage(
      {Key? key, required this.languageID, required this.update})
      : super(key: key);

  final String languageID;
  final Function(String) update;

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: S.of(context).Language,
        padding: EdgeInsets.symmetric(horizontal: 16),
        back: () => Navigator.pop(context),
        content: buildContent(context));
  }

  Widget buildContent(BuildContext context) {
    List<String> languageIDs = ["en", "vi"];
    List<String> languages = ["English", "Tiếng việt"];
    return Column(
        children: languages
            .map((e) => Column(children: [
                  GestureDetector(
                    onTap: () => update(languageIDs[languages.indexOf(e)]),
                    child: Container(
                        height: 52,
                        color: Colors.transparent,
                        child: Row(children: [
                          Image.asset(
                              (languageIDs[languages.indexOf(e)] == languageID)
                                  ? "assets/support_component/radio_check.png"
                                  : "assets/support_component/radio_uncheck.png",
                              height: 24,
                              fit: BoxFit.fitHeight),
                          SizedBox(width: 8),
                          Text(e,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      color:
                                          (languageIDs[languages.indexOf(e)] ==
                                                  languageID)
                                              ? AnthealthColors.primary1
                                              : null))
                        ])),
                  ),
                  CustomDivider.common()
                ]))
            .toList());
  }
}
