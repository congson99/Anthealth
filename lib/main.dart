import 'package:anthealth_mobile/blocs/app_cubit.dart';
import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/authentication/authentication_page.dart';
import 'package:anthealth_mobile/views/common_pages/app_loading_page.dart';
import 'package:anthealth_mobile/views/common_pages/error_page.dart';
import 'package:anthealth_mobile/views/common_pages/update_language_page.dart';
import 'package:anthealth_mobile/views/dashboard/dashboard_page.dart';
import 'package:anthealth_mobile/views/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  setOrientations();
  runApp(MyApp());
}

void setOrientations() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
        create: (context) => AppCubit(),
        child: BlocBuilder<AppCubit, CubitState>(builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: anthealthTheme(),
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: getUserLocale(state),
              home: buildSystemUiOverlay(context, state));
        }));
  }

  Widget buildSystemUiOverlay(BuildContext context, CubitState state) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: buildAppContent(context, state));
  }

  Widget buildAppContent(BuildContext context, CubitState state) {
    if (state is UnauthenticatedState) return AuthenticationPage();
    if (state is AuthenticatedState)
      return DashboardPage(user: state.user, languageID: state.languageID);
    if (state is ConnectErrorState)
      return ErrorPage(error: S.of(context).Cannot_connect);
    if (state is UpdateLanguageState)
      return UpdateLanguagePage(languageID: state.languageID);
    return AppLoadingPage();
  }

  dynamic getUserLocale(CubitState state) {
    if (state is AuthenticatedState) if (state.languageID != "")
      return Locale(state.languageID);
    return null;
  }
}
