import 'package:anthealth_mobile/views/common_widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key, this.error}) : super(key: key);

  final String? error;

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: CustomErrorWidget(error: error!),
        ),
      ));
}
