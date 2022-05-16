import 'package:anthealth_mobile/blocs/app_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/settings/general/setting_language_page.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:anthealth_mobile/views/z_dev_tool/dev_tool_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage(
      {Key? key, required this.appContext, required this.languageID})
      : super(key: key);

  final BuildContext appContext;
  final String languageID;

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: S.of(context).Settings,
        back: () => Navigator.pop(context),
        content: buildContent(context, appContext));
  }

  Widget buildContent(BuildContext context, BuildContext appContext) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        CommonText.section(S.of(context).General, context),
        SizedBox(height: 16),
        SectionComponent(
            title: S.of(context).Language,
            directionContent: getLanguage(context, languageID),
            colorID: 3,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SettingLanguagePage(
                    languageID: languageID,
                    update: (result) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      BlocProvider.of<AppCubit>(appContext)
                          .updateLanguage(result);
                    })))),
        SizedBox(height: 32),
        CustomDivider.common(),
        SizedBox(height: 16)
      ]),
      buildLogout(context, appContext)
    ]);
  }

  Column buildLogout(BuildContext context, BuildContext appContext) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SectionComponent(
          title: S.of(context).Logout,
          isDirection: false,
          colorID: 2,
          onTap: () {
            BlocProvider.of<AppCubit>(appContext).logout();
            Navigator.pop(context);
          }),
      SizedBox(height: 16),
      SectionComponent(
          title: "DEV TOOL",
          colorID: 3,
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => DevToolPage()));
          }),
      SizedBox(height: 16),
    ]);
  }

  String getLanguage(BuildContext context, String languageID) {
    switch (languageID) {
      case "vi":
        return "Tiếng Việt";
      case "en":
        return "English";
      default:
        return S.of(context).Auto;
    }
  }
}
