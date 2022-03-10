import 'package:anthealth_mobile/blocs/app_state.dart';
import 'package:anthealth_mobile/blocs/authentication/authentication_cubit.dart';
import 'package:anthealth_mobile/blocs/authentication/authetication_states.dart';
import 'package:anthealth_mobile/blocs/common_logic/authentication_logic.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_error_widget.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterComponent extends StatefulWidget {
  const RegisterComponent({Key? key}) : super(key: key);

  @override
  _RegisterComponentState createState() => _RegisterComponentState();
}

class _RegisterComponentState extends State<RegisterComponent> {
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
  Widget build(BuildContext context) =>
      BlocBuilder<AuthenticationCubit, CubitState>(builder: (context, state) {
        if (state is RegisterState)
          return buildContent(state.name, state.username, state.password,
              state.confirmPassword);
        else
          return CustomErrorWidget(error: S.of(context).something_wrong);
      });

  Widget buildContent(String name, String username, String password,
          String confirmPassword) =>
      SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32),
                buildHeading(),
                buildStepper(name, username, password, confirmPassword)
              ]));

  Widget buildHeading() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () => BlocProvider.of<AuthenticationCubit>(context)
                    .checkCurrentUsername(),
                child: Image.asset("assets/app_icon/direction/page_back.png",
                    height: 20, width: 20, fit: BoxFit.cover)),
            SizedBox(width: 16),
            Text(S.of(context).Register,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontFamily: 'RobotoMedium', color: AnthealthColors.black1))
          ]));

  Widget buildStepper(String name, String username, String password,
          String confirmPassword) =>
      Stepper(
          steps: [
            Step(
                title: Text(S.of(context).Fill_in_information),
                content:
                    buildFillStep(name, username, password, confirmPassword),
                isActive: _currentStep >= 0),
            Step(
                title: Text(S.of(context).Authenticate),
                content: buildAuthenticateStep(),
                isActive: _currentStep >= 1)
          ],
          currentStep: _currentStep,
          onStepContinue: () =>
              _onStepContinue(name, username, password, confirmPassword),
          onStepCancel: () => _onStepCancel(name, username));

  Widget buildFillStep(String name, String username, String password,
          String confirmPassword) =>
      Container(
          padding: const EdgeInsets.only(top: 4, right: 16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CommonTextField.round(
                    onChanged: (value) => setState(() {
                          BlocProvider.of<AuthenticationCubit>(context)
                              .updateRegisterState(
                                  value, username, password, confirmPassword);
                          _disappearError();
                        }),
                    context: context,
                    focusNode: _nameFocus,
                    errorText: (_errorName == '') ? null : _errorName,
                    labelText: S.of(context).Your_name),
                SizedBox(height: 16),
                CommonTextField.round(
                    onChanged: (value) => setState(() {
                          BlocProvider.of<AuthenticationCubit>(context)
                              .updateRegisterState(
                                  name, value, password, confirmPassword);
                          _disappearError();
                        }),
                    context: context,
                    focusNode: _usernameFocus,
                    errorText: (_errorUsername == '') ? null : _errorUsername,
                    labelText: S.of(context).Email),
                SizedBox(height: 16),
                CommonTextField.round(
                    onChanged: (value) => setState(() {
                          BlocProvider.of<AuthenticationCubit>(context)
                              .updateRegisterState(
                                  name, username, value, confirmPassword);
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
                          BlocProvider.of<AuthenticationCubit>(context)
                              .updateRegisterState(
                                  name, username, password, value);
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
  void _onStepContinue(
      String name, String username, String password, String confirmPassword) {
    if (_currentStep == 0) {
      if (_checkName(name, username) &&
          _checkUsername(name, username) &&
          _checkPassword(name, username, password, confirmPassword)) {
        if (BlocProvider.of<AuthenticationCubit>(context)
            .checkRegisteredAccount(username))
          setState(() {
            _errorUsername = S.of(context).Registered_email;
            _clearPassword(name, username);
          });
        else
          setState(() {
            _currentStep += 1;
            FocusScope.of(context).requestFocus(_codeFocus);
          });
      }
    } else {
      if (_checkAuthenticationCode() &&
          BlocProvider.of<AuthenticationCubit>(context)
              .registerAccount(name, username, password)) {
        BlocProvider.of<AuthenticationCubit>(context)
            .intentLogin(username, password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(S.of(context).Register +
                ' ' +
                S.of(context).successfully +
                '!')));
      }
    }
  }

  void _onStepCancel(String name, String username) {
    setState(() {
      if (_currentStep == 0)
        BlocProvider.of<AuthenticationCubit>(context).checkCurrentUsername();
      else {
        _clearPassword(name, username);
        _currentStep -= 1;
        _authenticationCodeController.clear();
      }
    });
  }

  bool _checkName(String name, String username) {
    if (name == '') {
      setState(() {
        _errorName = S.of(context).Enter_name;
        _clearPassword(name, username);
      });
      FocusScope.of(context).requestFocus(_nameFocus);
      return false;
    }
    return true;
  }

  bool _checkUsername(String name, String username) {
    var _result = AuthenticationLogic.checkValidEmail(context, username);
    if (_result != 'ok') {
      setState(() {
        _errorUsername = _result;
        _clearPassword(name, username);
      });
      FocusScope.of(context).requestFocus(_usernameFocus);
      return false;
    }
    return true;
  }

  bool _checkPassword(
      String name, String username, String password, String confirmPassword) {
    var _passwordResult =
        AuthenticationLogic.checkValidPassword(context, password);
    if (_passwordResult != 'ok') {
      setState(() {
        _errorPassword = _passwordResult;
        _clearPassword(name, username);
      });
      FocusScope.of(context).requestFocus(_passwordFocus);
      return false;
    }
    var _confirmPasswordResult =
        AuthenticationLogic.checkValidConfirmPassword(context, confirmPassword);
    if (_confirmPasswordResult != 'ok') {
      setState(() {
        _errorConfirmPassword = _confirmPasswordResult;
        _clearPassword(name, username, password);
      });
      FocusScope.of(context).requestFocus(_passwordFocus);
      return false;
    }
    if (password != confirmPassword) {
      setState(() {
        _errorPassword = S.of(context).Not_match_password;
        _errorConfirmPassword = S.of(context).Not_match_password;
        _clearPassword(name, username);
      });
      FocusScope.of(context).requestFocus(_passwordFocus);
      return false;
    }
    return true;
  }

  bool _checkAuthenticationCode() {
    if (_code == '000000') return true;
    setState(() {
      _errorCode = S.of(context).Wrong_authentication_code;
      _clearAuthenticationCode();
    });
    FocusScope.of(context).requestFocus(_codeFocus);
    return false;
  }

  void _disappearError() {
    _errorName = '';
    _errorUsername = '';
    _errorPassword = '';
    _errorConfirmPassword = '';
    _errorCode = '';
  }

  void _clearPassword(String name, String username, [String? password]) {
    var pass = (password != null) ? password : '';
    BlocProvider.of<AuthenticationCubit>(context)
        .updateRegisterState(name, username, pass, '');
    if (password == null) _passwordController.clear();
    _confirmPasswordController.clear();
  }

  void _clearAuthenticationCode() {
    _authenticationCodeController.clear();
    _code = '';
  }
}
