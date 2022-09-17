import 'package:anthealth_mobile/blocs/authentication/authentication_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/authentication/authentication_models.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_snackbar.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordComponent extends StatefulWidget {
  const ForgotPasswordComponent({Key? key}) : super(key: key);

  @override
  _ForgotPasswordComponentState createState() =>
      _ForgotPasswordComponentState();
}

class _ForgotPasswordComponentState extends State<ForgotPasswordComponent> {
  String _username = '';
  String _password = '';
  String _confirmPassword = '';
  String _code = '';
  String _errorUsername = '';
  String _errorPassword = '';
  String _errorConfirmPassword = '';
  String _errorCode = '';

  int _currentStep = 0;

  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  var _authenticationCodeController = TextEditingController();

  var _usernameFocus = FocusNode();
  var _passwordFocus = FocusNode();
  var _confirmPasswordFocus = FocusNode();
  var _codeFocus = FocusNode();

  @override
  Widget build(BuildContext context) => buildContent();

  Widget buildContent() => SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [SizedBox(height: 32), buildHeading(), buildStepper()]));

  Widget buildHeading() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {},
                child: Image.asset("assets/app_icon/direction/page_back.png",
                    height: 20, width: 20, fit: BoxFit.cover)),
            SizedBox(width: 16),
            Text(S.of(context).Forgot_password,
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
                isActive: _currentStep >= 1),
            Step(
                title: Text(S.of(context).Set_new_password),
                content: buildSetNewPasswordStep(),
                isActive: _currentStep >= 2)
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
                      _username = value;
                      _disappearError();
                    }),
                context: context,
                focusNode: _usernameFocus,
                errorText: (_errorUsername == '') ? null : _errorUsername,
                labelText: S.of(context).Email)
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

  Widget buildSetNewPasswordStep() => Container(
      padding: const EdgeInsets.only(top: 4, right: 16),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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

  // Hepper functions
  void _onStepContinue() {
    if (_currentStep == 0) {
      if (_checkUsername()) {
        setState(() {
          _currentStep += 1;
          FocusScope.of(context).requestFocus(_codeFocus);
        });
      }
    } else if (_currentStep == 1) {
      if (_checkAuthenticationCode()) {
        _clearAuthenticationCode();
        setState(() {
          _currentStep += 1;
          FocusScope.of(context).requestFocus(_passwordFocus);
        });
      }
    } else {
      if (_checkPassword()) {
        ShowSnackBar.showSuccessSnackBar(
            context,
            S.of(context).Set_new_password +
                ' ' +
                S.of(context).successfully +
                '!');
        BlocProvider.of<AuthenticationCubit>(context).login(LoginData('', ''));
      }
    }
  }

  void _onStepCancel() {
    if (_currentStep == 0)
      Navigator.pop(context);
    else if (_currentStep == 1) {
      setState(() {
        _clearAuthenticationCode();
        _currentStep -= 1;
      });
    } else {
      setState(() {
        _clearPassword();
        _currentStep -= 1;
      });
    }
  }

  bool _checkUsername() {
    if (_username == '') {
      setState(() {
        _errorUsername = S.of(context).Enter_email;
      });
      FocusScope.of(context).requestFocus(_usernameFocus);
      return false;
    }
    if (_username != 'congson') {
      setState(() {
        _errorUsername = S.of(context).Not_registered_email;
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
