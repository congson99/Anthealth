import 'dart:math';

import 'package:anthealth_mobile/blocs/app_cubit.dart';
import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/authentication/authentication_cubit.dart';
import 'package:anthealth_mobile/blocs/authentication/authetication_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/authentication_logic.dart';
import 'package:anthealth_mobile/models/authentication/authentication_models.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_error_widget.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginComponent extends StatefulWidget {
  const LoginComponent(
      {Key? key, this.intentData, required this.heightSafeArea})
      : super(key: key);

  final LoginData? intentData;
  final double heightSafeArea;

  @override
  _LoginComponentState createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  String _errorUsername = 'null';
  String _errorPassword = 'null';
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _usernameFocus = FocusNode();
  var _passwordFocus = FocusNode();

  @override
  void initState() {
    _autoFill();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, CubitState>(
        builder: (context, state) {
      if (state is LoginState) return buildContent(context, state.loginData);
      return CustomErrorWidget(error: S.of(context).something_wrong);
    });
  }

  Widget buildContent(BuildContext context, LoginData data) {
    double keyboardHeight = EdgeInsets.fromWindowPadding(
            WidgetsBinding.instance!.window.viewInsets,
            WidgetsBinding.instance!.window.devicePixelRatio)
        .bottom;
    return SingleChildScrollView(
        child: Column(children: [
      buildLogoArea(keyboardHeight),
      buildLoginArea(keyboardHeight, data),
      buildRegisterArea()
    ]));
  }

  Widget buildLogoArea(double keyboardHeight) {
    double logoAreaHeight = (keyboardHeight > 100)
        ? (widget.heightSafeArea * 0.15)
        : (widget.heightSafeArea * 0.3);
    return Container(
        height: logoAreaHeight,
        width: min(MediaQuery.of(context).size.width * 3 / 5, 350),
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 16),
        child: Image.asset("assets/app_text_logo_slogan.png",
            fit: BoxFit.fitWidth));
  }

  Widget buildLoginArea(double keyboardHeight, LoginData data) {
    const double maxLogoWidth = 450;
    double loginAreaHeight = (keyboardHeight > 100)
        ? (widget.heightSafeArea * 0.9 - keyboardHeight)
        : (widget.heightSafeArea * 0.6);
    return Container(
        height: loginAreaHeight,
        width: min(MediaQuery.of(context).size.width, maxLogoWidth),
        padding: const EdgeInsets.all(32),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          CommonTextField.round(
              onChanged: (value) => setState(() {
                    BlocProvider.of<AuthenticationCubit>(context)
                        .login(LoginData(value, data.password));
                    _disappearError();
                  }),
              context: context,
              textInputAction: TextInputAction.next,
              focusNode: _usernameFocus,
              textEditingController: _usernameController,
              errorText: (_errorUsername == 'null') ? null : _errorUsername,
              labelText: S.of(context).Email),
          SizedBox(height: 16),
          CommonTextField.round(
              onChanged: (value) => setState(() {
                    BlocProvider.of<AuthenticationCubit>(context)
                        .login(LoginData(data.username, value));
                    _disappearError();
                  }),
              context: context,
              focusNode: _passwordFocus,
              errorText: (_errorPassword == 'null') ? null : _errorPassword,
              textEditingController: _passwordController,
              labelText: S.of(context).Password,
              isVisibility: true),
          SizedBox(height: 16),
          Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: InkWell(
                  onTap: () => {},
                  child: Text(S.of(context).Forgot_password,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: AnthealthColors.primary1)))),
          SizedBox(height: 16),
          CommonButton.round(context, () => _loginAuthentication(context, data),
              S.of(context).button_login, AnthealthColors.primary1)
        ]));
  }

  Widget buildRegisterArea() {
    final RegisterData initialRegisterData = RegisterData('', '', '', '');
    return Container(
        height: widget.heightSafeArea * 0.1,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(S.of(context).You_are_new_user,
              style: Theme.of(context).textTheme.bodyText2),
          SizedBox(height: 4),
          InkWell(
              onTap: () => BlocProvider.of<AuthenticationCubit>(context)
                  .register(initialRegisterData),
              child: Text(S.of(context).Register_now,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: AnthealthColors.primary1)))
        ]));
  }

  // Hepper Functions
  void _autoFill() {
    if (widget.intentData != null) {
      _usernameController.text = widget.intentData!.username;
      _passwordController.text = widget.intentData!.password;
    }
  }

  void _loginAuthentication(BuildContext context, LoginData loginData) {
    FocusScope.of(context).unfocus();
    if (_checkUsername(loginData.username) && _checkPassword(loginData)) {
      BlocProvider.of<AuthenticationCubit>(context)
          .getToken(loginData)
          .then((token) {
        if (token == null) {
          setState(() {
            _errorUsername = S.of(context).Wrong_email_or_password;
            _clearPassword(loginData.username);
          });
          FocusScope.of(context).requestFocus(_usernameFocus);
        } else
          BlocProvider.of<AppCubit>(context).login(token, loginData.username);
      });
    }
  }

  bool _checkUsername(String username) {
    dynamic result = AuthenticationLogic.emailError(context, username);
    if (result == null) return true;
    setState(() {
      _errorUsername = result;
      _clearPassword(username);
    });
    FocusScope.of(context).requestFocus(_usernameFocus);
    return false;
  }

  bool _checkPassword(LoginData loginData) {
    var result = AuthenticationLogic.passwordError(context, loginData.password);
    if (result == null) return true;
    setState(() {
      _errorPassword = result;
      _clearPassword(loginData.username);
    });
    FocusScope.of(context).requestFocus(_passwordFocus);
    return false;
  }

  void _disappearError() {
    _errorUsername = 'null';
    _errorPassword = 'null';
  }

  void _clearPassword(String username) {
    BlocProvider.of<AuthenticationCubit>(context)
        .login(LoginData(username, ''));
    _passwordController.clear();
  }
}
