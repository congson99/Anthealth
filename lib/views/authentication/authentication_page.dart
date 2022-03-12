import 'package:anthealth_mobile/blocs/app_state.dart';
import 'package:anthealth_mobile/blocs/authentication/authentication_cubit.dart';
import 'package:anthealth_mobile/blocs/authentication/authetication_states.dart';
import 'package:anthealth_mobile/views/authentication/forgot_password_component.dart';
import 'package:anthealth_mobile/views/authentication/login_component.dart';
import 'package:anthealth_mobile/views/authentication/register_component.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: Stack(children: [
        buildBackground(context),
        SafeArea(child: buildContent())
      ]));

  Widget buildBackground(BuildContext context) => Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Image.asset("assets/background.png", fit: BoxFit.cover));

  BlocProvider<AuthenticationCubit> buildContent() {
    return BlocProvider<AuthenticationCubit>(
        create: (context) => AuthenticationCubit(),
        child: BlocBuilder<AuthenticationCubit, CubitState>(
            builder: (context, state) {
          if (state is LoginState)
            return new LoginComponent(intentData: state.loginData);
          if (state is RegisterState) return RegisterComponent();
          if (state is ForgotPasswordState)
            return ForgotPasswordComponent();
          else
            return LoadingPage();
        }));
  }
}
