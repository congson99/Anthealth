import 'dart:math';

import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/theme/colors.dart';
import 'package:anthealth_mobile/views/authentication/forgot_password_page.dart';
import 'package:anthealth_mobile/views/authentication/register_page.dart';
import 'package:anthealth_mobile/views/main_page.dart';
import 'package:anthealth_mobile/widgets/common_button.dart';
import 'package:anthealth_mobile/widgets/common_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage(
      {Key? key, this.intentUsername, this.intentPassword})
      : super(key: key);

  final String? intentUsername;
  final String? intentPassword;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username = '';
  String _password = '';
  String _errorUsername = 'null';
  String _errorPassword = 'null';

  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();

  var _usernameFocus = FocusNode();
  var _passwordFocus = FocusNode();

  @override
  void initState() {
    _checkAutoFill();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Stack(children: [buildBackground(context), buildContent()]));

  // Component Widgets
  Widget buildBackground(BuildContext context) => Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Image.asset("assets/background.png", fit: BoxFit.cover));

  Widget buildContent() => Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Expanded(child: buildLogo()),
            SizedBox(height: 64),
            buildLoginArea(),
            Expanded(child: buildRegisterArea())
          ]));

  Widget buildLogo() => Container(
      width: min(MediaQuery.of(context).size.width * 3 / 5, 350),
      alignment: Alignment.bottomCenter,
      child:
          Image.asset("assets/app_text_logo_slogan.png", fit: BoxFit.fitWidth));

  Widget buildLoginArea() => Container(
      width: min(MediaQuery.of(context).size.width, 450),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonTextField.round(
                onChanged: (value) => setState(() {
                      _username = value;
                      _disappearError();
                    }),
                context: context,
                focusNode: _usernameFocus,
                textEditingController: _usernameController,
                errorText: (_errorUsername == 'null') ? null : _errorUsername,
                labelText: S.of(context).Email),
            SizedBox(height: 16),
            CommonTextField.round(
                onChanged: (value) => setState(() {
                      _password = value;
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
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ForgotPasswordPage())),
                    child: Text(S.of(context).Forgot_password,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: AnthealthColors.primary1)))),
            SizedBox(height: 16),
            CommonButton.round(context, () => _loginAuthentication(),
                S.of(context).button_login, AnthealthColors.primary1)
          ]));

  Widget buildRegisterArea() => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(S.of(context).You_are_new_user,
                style: Theme.of(context).textTheme.bodyText2),
            SizedBox(height: 4),
            Container(
                alignment: Alignment.center,
                child: InkWell(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => RegisterPage())),
                    child: Text(S.of(context).Register_now,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: AnthealthColors.primary1)))),
            SizedBox(height: 48)
          ]);

  // Hepper Functions
  void _checkAutoFill() {
    if (widget.intentUsername != null && widget.intentPassword != null) {
      _username = widget.intentUsername!;
      _password = widget.intentPassword!;
      _usernameController.text = widget.intentUsername!;
      _passwordController.text = widget.intentPassword!;
    }
  }

  void _loginAuthentication() {
    if (_checkUsername()) if (_checkPassword()) {
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => MainPage()));
    }
  }

  bool _checkUsername() {
    if (_username == '') {
      setState(() {
        _errorUsername = S.of(context).Enter_email;
        _clearPassword();
      });
      FocusScope.of(context).requestFocus(_usernameFocus);
      return false;
    }
    if (_username != 'congson') {
      setState(() {
        _errorUsername = S.of(context).Not_registered_email;
        _clearPassword();
      });
      FocusScope.of(context).requestFocus(_usernameFocus);
      return false;
    }
    return true;
  }

  bool _checkPassword() {
    if (_password == '') {
      setState(() {
        _errorPassword = S.of(context).Enter_password;
        _clearPassword();
      });
      FocusScope.of(context).requestFocus(_passwordFocus);
      return false;
    }
    if (_password != '123') {
      setState(() {
        _errorPassword = S.of(context).Wrong_password;
        _clearPassword();
      });
      FocusScope.of(context).requestFocus(_passwordFocus);
      return false;
    }
    return true;
  }

  void _disappearError() {
    _errorUsername = 'null';
    _errorPassword = 'null';
  }

  void _clearPassword() {
    _passwordController.clear();
    _password = '';
  }
}
