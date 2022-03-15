import 'package:anthealth_mobile/blocs/app_cubit.dart';
import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/authentication/authentication_page.dart';
import 'package:anthealth_mobile/views/common_pages/app_loading_page.dart';
import 'package:anthealth_mobile/views/common_pages/error_page.dart';
import 'package:anthealth_mobile/views/dashboard/dashboard_page.dart';
import 'package:anthealth_mobile/views/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: anthealthTheme(),
      locale: Locale('vi'),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: buildRootApp());

  Widget buildRootApp() => BlocProvider<AppCubit>(
      create: (context) => AppCubit(),
      child: BlocBuilder<AppCubit, CubitState>(builder: (context, state) {
        if (state is UnauthenticatedState) return AuthenticationPage();
        if (state is AuthenticatedState)
          return DashboardPage(name: state.name, avatarPath: state.avatarPath);
        if (state is ConnectErrorState)
          return ErrorPage(error: S.of(context).Cannot_connect);
        return AppLoadingPage();
      }));
}
