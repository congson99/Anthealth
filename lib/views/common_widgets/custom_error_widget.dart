import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({Key? key, this.error}) : super(key: key);

  final String? error;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Image.asset("assets/app_icon/common/error_war3.png",
              height: 80.0, width: 80.0, fit: BoxFit.cover),
          SizedBox(height: 16),
          if (error != null)
            Text(error!,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AnthealthColors.warning2))
        ]));
  }
}
