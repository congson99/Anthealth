import 'package:anthealth_mobile/blocs/app_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/z_dev_tool/dev_tool_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key, required this.appContext}) : super(key: key);

  final BuildContext appContext;

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: S.of(context).Settings,
        back: () => Navigator.pop(context),
        content: buildContent(context, appContext));
  }

  Widget buildContent(BuildContext context, BuildContext appContext) {
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
          })
    ]);
  }
}
