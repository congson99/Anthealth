import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

class HealthPage extends StatelessWidget {
  const HealthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(S.of(context).health));
  }
}
