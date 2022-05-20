import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorSettingsPage extends StatelessWidget {
  const DoctorSettingsPage({Key? key, required this.appContext})
      : super(key: key);

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
      buildGeneral(context, appContext),
      buildExit(context, appContext)
    ]);
  }

  Widget buildGeneral(BuildContext context, BuildContext appContext) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CommonText.section(S.of(context).General, context),
      SizedBox(height: 16),
      SizedBox(height: 32),
      CustomDivider.common(),
      SizedBox(height: 16)
    ]);
  }

  Widget buildExit(BuildContext context, BuildContext appContext) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SectionComponent(
          title: S.of(context).Exit_doctor_mode,
          iconPath: "assets/app_icon/common/out_war0.png",
          isDirection: false,
          colorID: 2,
          onTap: () {
            Navigator.pop(context);
            BlocProvider.of<DashboardCubit>(appContext).home();
          })
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
