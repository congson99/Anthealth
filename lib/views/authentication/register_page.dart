import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/theme/colors.dart';
import 'package:anthealth_mobile/views/authentication/login_page.dart';
import 'package:anthealth_mobile/widgets/common_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _name = '';
  String _username = '';
  String _password = '';
  String _confirmPassword = '';
  String _code = '';
  String _errorName = '';
  String _errorUsername = '';
  String _errorPassword = '';
  String _errorConfirmPassword = '';
  String _errorCode = '';

  int _currentStep = 0;

  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  var _authenticationCodeController = TextEditingController();

  var _nameFocus = FocusNode();
  var _usernameFocus = FocusNode();
  var _passwordFocus = FocusNode();
  var _confirmPasswordFocus = FocusNode();
  var _codeFocus = FocusNode();

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Stack(children: [buildBackground(context), buildContent()]));

  // Component Widgets
  Widget buildBackground(BuildContext context) => Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Image.asset("assets/background.png", fit: BoxFit.cover));

  Widget buildContent() => Center(
      child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [buildHeading(), buildStepper()])));

  Widget buildHeading() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Image.asset("assets/app_icon/direction/page_back.png",
                    height: 20, width: 20, fit: BoxFit.cover)),
            SizedBox(width: 16),
            Text(S.of(context).Register,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontFamily: 'RobotoMedium', color: AnthealthColors.black1))
          ]));

  Widget buildStepper() => Stepper(
          steps: [
            Step(
                title: Text(S.of(context).Fill_in_information),
                content: buildFillStep(),
                isActive: _currentStep >= 0),
            Step(
                title: Text(S.of(context).Authenticate),
                content: buildAuthenticateStep(),
                isActive: _currentStep >= 1)
          ],
          currentStep: _currentStep,
          onStepContinue: () => _onStepContinue(),
          onStepCancel: () => _onStepCancel());

  Widget buildFillStep() => Container(
      padding: const EdgeInsets.only(top: 4, right: 16),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonTextField.round(
                onChanged: (value) => setState(() {
                      _name = value;
                      _disappearError();
                    }),
                context: context,
                focusNode: _nameFocus,
                errorText: (_errorName == '') ? null : _errorName,
                labelText: S.of(context).Your_name),
            SizedBox(height: 16),
            CommonTextField.round(
                onChanged: (value) => setState(() {
                      _username = value;
                      _disappearError();
                    }),
                context: context,
                focusNode: _usernameFocus,
                errorText: (_errorUsername == '') ? null : _errorUsername,
                labelText: S.of(context).Email),
            SizedBox(height: 16),
            CommonTextField.round(
                onChanged: (value) => setState(() {
                      _password = value;
                      _disappearError();
                    }),
                context: context,
                focusNode: _passwordFocus,
                textEditingController: _passwordController,
                errorText: (_errorPassword == '') ? null : _errorPassword,
                labelText: S.of(context).Password,
                isVisibility: true),
            SizedBox(height: 16),
            CommonTextField.round(
                onChanged: (value) => setState(() {
                      _confirmPassword = value;
                      _disappearError();
                    }),
                context: context,
                focusNode: _confirmPasswordFocus,
                textEditingController: _confirmPasswordController,
                errorText: (_errorConfirmPassword == '')
                    ? null
                    : _errorConfirmPassword,
                labelText: S.of(context).Confirm_password,
                isVisibility: true)
          ]));

  Widget buildAuthenticateStep() => Container(
      padding: const EdgeInsets.only(top: 4, right: 16),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonTextField.round(
                onChanged: (value) => setState(() {
                      _code = value;
                      _disappearError();
                    }),
                focusNode: _codeFocus,
                errorText: (_errorCode == '') ? null : _errorCode,
                context: context,
                textEditingController: _authenticationCodeController,
                labelText: S.of(context).Authentication_code),
          ]));

  // Hepper functions
  void _onStepContinue() {
    if (_currentStep == 0) {
      if (_checkName()) if (_checkUsername()) if (_checkPassword()) {
        setState(() {
          _clearPassword();
          _currentStep += 1;
          FocusScope.of(context).requestFocus(_codeFocus);
        });
      }
    } else {
      if (_checkAuthenticationCode()) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(S.of(context).Register +
                ' ' +
                S.of(context).successfully +
                '!')));
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) =>
                LoginPage(intentUsername: 'congson', intentPassword: '123')));
      }
    }
  }

  void _onStepCancel() {
    setState(() {
      if (_currentStep == 0)
        Navigator.pop(context);
      else {
        _authenticationCodeController.clear();
        _currentStep -= 1;
      }
    });
  }

  bool _checkName() {
    if (_name == '') {
      setState(() {
        _errorName = S.of(context).Enter_name;
        _clearPassword();
      });
      FocusScope.of(context).requestFocus(_nameFocus);
      return false;
    }
    return true;
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
    if (_username == 'congson') {
      setState(() {
        _errorUsername = S.of(context).Registered_email;
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
    if (_confirmPassword == '') {
      setState(
          () => _errorConfirmPassword = S.of(context).Enter_confirm_password);
      FocusScope.of(context).requestFocus(_confirmPasswordFocus);
      return false;
    }
    if (_password != _confirmPassword) {
      setState(() {
        _errorPassword = S.of(context).Not_match_password;
        _errorConfirmPassword = S.of(context).Not_match_password;
        _clearPassword();
      });
      FocusScope.of(context).requestFocus(_passwordFocus);
      return false;
    }
    return true;
  }

  bool _checkAuthenticationCode() {
    if (_code == '000000')
      return true;
    else {
      setState(() {
        _errorCode = S.of(context).Wrong_authentication_code;
        _clearAuthenticationCode();
      });
      FocusScope.of(context).requestFocus(_codeFocus);
      return false;
    }
  }

  void _disappearError() {
    _errorName = '';
    _errorUsername = '';
    _errorPassword = '';
    _errorConfirmPassword = '';
    _errorCode = '';
  }

  void _clearPassword() {
    _passwordController.clear();
    _confirmPasswordController.clear();
    _password = '';
    _confirmPassword = '';
  }

  void _clearAuthenticationCode() {
    _authenticationCodeController.clear();
    _code = '';
  }
}
