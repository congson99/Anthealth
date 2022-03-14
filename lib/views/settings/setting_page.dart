import 'package:anthealth_mobile/blocs/app_cubit.dart';
import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/authentication/authentication_cubit.dart';
import 'package:anthealth_mobile/blocs/authentication/authetication_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_appbar.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_error_widget.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key, required this.appContext}) : super(key: key);

  final BuildContext appContext;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
            child: Stack(children: [
          Container(
              margin: const EdgeInsets.only(top: 65),
              child: SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: buildContent(context, appContext)))),
          CustomAppBar(
              title: S.of(context).Settings, back: () => Navigator.pop(context))
        ])),
      );

  buildContent(BuildContext context, BuildContext appContext) =>
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonButton.round(context, () {
              BlocProvider.of<AppCubit>(appContext).unAuthenticate();
              Navigator.pop(context);
            }, 'LOGOUT', AnthealthColors.warning2)
          ],
        ),
      );
}
