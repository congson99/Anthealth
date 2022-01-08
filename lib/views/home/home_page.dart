import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:flutter/cupertino.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(S.of(context).home));
  }
}
