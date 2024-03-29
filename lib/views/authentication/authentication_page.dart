import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/authentication/authentication_cubit.dart';
import 'package:anthealth_mobile/blocs/authentication/authetication_states.dart';
import 'package:anthealth_mobile/views/authentication/forgot_password_component.dart';
import 'package:anthealth_mobile/views/authentication/login_component.dart';
import 'package:anthealth_mobile/views/authentication/register_component.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double heightSafeArea = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Scaffold(
        body: Stack(children: [
      buildBackground(context),
      SafeArea(child: buildContent(heightSafeArea))
    ]));
  }

  Widget buildBackground(BuildContext context) => Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Image.asset("assets/background.png", fit: BoxFit.cover));

  Widget buildContent(double heightSafeArea) {
    return BlocProvider<AuthenticationCubit>(
        create: (context) => AuthenticationCubit(),
        child: BlocBuilder<AuthenticationCubit, CubitState>(
            builder: (context, state) {
          if (state is LoginState)
            return new LoginComponent(
              intentData: state.loginData,
              heightSafeArea: heightSafeArea,
            );
          if (state is RegisterState) return RegisterComponent();
          if (state is ForgotPasswordState) return ForgotPasswordComponent();
          return LoadingPage();
        }));
  }
}
