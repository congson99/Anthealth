import 'package:anthealth_mobile/blocs/app_cubit.dart';
import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/language/language_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/authentication/authentication_page.dart';
import 'package:anthealth_mobile/views/common_pages/app_loading_page.dart';
import 'package:anthealth_mobile/views/common_pages/error_page.dart';
import 'package:anthealth_mobile/views/dashboard/dashboard_page.dart';
import 'package:anthealth_mobile/views/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  setOrientations();
  await Firebase.initializeApp();
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
    return BlocProvider<LanguageCubit>(
        create: (context) => LanguageCubit(),
        child:
            BlocBuilder<LanguageCubit, CubitState>(builder: (context, lState) {
          if (lState is LanguageState) {
            return BlocProvider<AppCubit>(
                create: (context) => AppCubit(),
                child: BlocBuilder<AppCubit, CubitState>(
                    builder: (context, state) {
                  return MaterialApp(
                      initialRoute: '/',
                      debugShowCheckedModeBanner: false,
                      theme: anthealthTheme(),
                      localizationsDelegates: const [
                        S.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: S.delegate.supportedLocales,
                      locale: Locale(lState.language),
                      home: buildSystemUiOverlay(context, state));
                }));
          }
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: anthealthTheme(),
              home: AppLoadingPage());
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
      return DashboardPage(
          user: state.user, review: state.review, warning: state.warning);
    if (state is ConnectErrorState)
      return CustomErrorPage(error: S.of(context).Cannot_connect);
    return AppLoadingPage();
  }
}
