import 'package:anthealth_mobile/services/client.dart';
import 'package:anthealth_mobile/services/service.dart';
// import 'package:anthealth_mobile/theme/theme.dart';
// import 'package:anthealth_mobile/views/authentication/login_component.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
//
// import 'generated/l10n.dart';

void main() {
  // runApp(MyApp());
  CommonService.instance;
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: anthealthTheme(),
//       locale: Locale('vi'),
//       localizationsDelegates: [
//         S.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: S.delegate.supportedLocales,
//       home: LoginPage(),
//     );
//   }
// }