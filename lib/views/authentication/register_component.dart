import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/authentication/authentication_cubit.dart';
import 'package:anthealth_mobile/blocs/authentication/authetication_states.dart';
import 'package:anthealth_mobile/blocs/common_logic/authentication_logic.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/authentication/authentication_models.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_error_widget.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterComponent extends StatefulWidget {
  const RegisterComponent({Key? key}) : super(key: key);

  @override
  _RegisterComponentState createState() => _RegisterComponentState();
}

class _RegisterComponentState extends State<RegisterComponent> {
  String _errorName = '';
  String _errorUsername = '';
  String _errorPassword = '';
  String _errorConfirmPassword = '';

  // String _code = '';
  // String _errorCode = '';

  int _currentStep = 0;

  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();

  // var _authenticationCodeController = TextEditingController();

  var _nameFocus = FocusNode();
  var _usernameFocus = FocusNode();
  var _passwordFocus = FocusNode();
  var _confirmPasswordFocus = FocusNode();

  // var _codeFocus = FocusNode();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthenticationCubit, CubitState>(builder: (context, state) {
        if (state is RegisterState) return buildContent(state.registerData);
        return CustomErrorWidget(error: S.of(context).something_wrong);
      });

  Widget buildContent(RegisterData data) => SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            SizedBox(height: 32),
            buildHeading(),
            buildStepper(data)
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

  Widget buildStepper(RegisterData data) => Stepper(
          steps: [
            Step(
                title: Text(S.of(context).Fill_in_information),
                content: buildFillStep(data),
                isActive: _currentStep >= 0),
            Step(
                title: Text(S.of(context).Authenticate),
                content: buildAuthenticateStep(),
                isActive: _currentStep >= 1)
          ],
          currentStep: _currentStep,
          onStepContinue: () => _onStepContinue(data),
          onStepCancel: () => _onStepCancel());

  Widget buildFillStep(RegisterData data) => Container(
      padding: const EdgeInsets.only(top: 4, right: 16),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonTextField.round(
                onChanged: (value) => setState(() {
                      BlocProvider.of<AuthenticationCubit>(context).register(
                          RegisterData(value, data.getUsername(),
                              data.getPassword(), data.confirmPassword()));
                      _disappearError();
                    }),
                context: context,
                focusNode: _nameFocus,
                errorText: (_errorName == '') ? null : _errorName,
                labelText: S.of(context).Your_name),
            SizedBox(height: 16),
            CommonTextField.round(
                onChanged: (value) => setState(() {
                      BlocProvider.of<AuthenticationCubit>(context).register(
                          RegisterData(data.getName(), value,
                              data.getPassword(), data.confirmPassword()));
                      _disappearError();
                    }),
                context: context,
                focusNode: _usernameFocus,
                errorText: (_errorUsername == '') ? null : _errorUsername,
                labelText: S.of(context).Email),
            SizedBox(height: 16),
            CommonTextField.round(
                onChanged: (value) => setState(() {
                      BlocProvider.of<AuthenticationCubit>(context).register(
                          RegisterData(data.getName(), data.getUsername(),
                              value, data.confirmPassword()));
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
                      BlocProvider.of<AuthenticationCubit>(context).register(
                          RegisterData(data.getName(), data.getUsername(),
                              value, value));
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
      // padding: const EdgeInsets.only(top: 4, right: 16),
      // child: Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: [
      //       CommonTextField.round(
      //           onChanged: (value) => setState(() {
      //                 _code = value;
      //                 _disappearError();
      //               }),
      //           focusNode: _codeFocus,
      //           errorText: (_errorCode == '') ? null : _errorCode,
      //           context: context,
      //           textEditingController: _authenticationCodeController,
      //           labelText: S.of(context).Authentication_code),
      //     ])
      );

  // Hepper functions
  void _onStepContinue(RegisterData data) {
    if (_currentStep == 0) {
      if (_checkName(data) && _checkUsername(data) && _checkPassword(data)) {
        BlocProvider.of<AuthenticationCubit>(context)
            .registerAccount(data)
            .then((value) {
          if (value == 1)
            setState(() {
              _errorUsername = S.of(context).Registered_email;
              _clearPassword(data);
            });
          if (value == 0) {
            BlocProvider.of<AuthenticationCubit>(context)
                .intentLogin(LoginData(data.getUsername(), data.getPassword()));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(S.of(context).Register +
                    ' ' +
                    S.of(context).successfully +
                    '!')));
          }
          if (value == 2) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Register false!")));
          }
        });
      }
    }
  }

  void _onStepCancel() {
    setState(() {
      if (_currentStep == 0)
        BlocProvider.of<AuthenticationCubit>(context).checkCurrentUsername();
      // else {
      //   _clearPassword(name, username);
      //   _currentStep -= 1;
      //   _authenticationCodeController.clear();
      // }
    });
  }

  bool _checkName(RegisterData data) {
    if (data.getName() != '') return true;
    setState(() {
      _errorName = S.of(context).Enter_name;
      _clearPassword(data);
    });
    FocusScope.of(context).requestFocus(_nameFocus);
    return false;
  }

  bool _checkUsername(RegisterData data) {
    var _result =
        AuthenticationLogic.checkValidEmail(context, data.getUsername());
    if (_result == 'ok') return true;
    setState(() {
      _errorUsername = _result;
      _clearPassword(data);
    });
    FocusScope.of(context).requestFocus(_usernameFocus);
    return false;
  }

  bool _checkPassword(RegisterData data) {
    var _passwordResult =
        AuthenticationLogic.checkValidPassword(context, data.getPassword());
    var _confirmPasswordResult = AuthenticationLogic.checkValidConfirmPassword(
        context, data.confirmPassword());
    if (_passwordResult != 'ok') {
      setState(() {
        _errorPassword = _passwordResult;
        _clearPassword(data);
      });
      FocusScope.of(context).requestFocus(_passwordFocus);
      return false;
    }
    if (_confirmPasswordResult != 'ok') {
      setState(() {
        _errorConfirmPassword = _confirmPasswordResult;
        _clearPassword(data, true);
      });
      FocusScope.of(context).requestFocus(_passwordFocus);
      return false;
    }
    if (data.getPassword() != data.confirmPassword()) {
      setState(() {
        _errorPassword = S.of(context).Not_match_password;
        _errorConfirmPassword = S.of(context).Not_match_password;
        _clearPassword(data);
      });
      FocusScope.of(context).requestFocus(_passwordFocus);
      return false;
    }
    return true;
  }

  // bool _checkAuthenticationCode() {
  //   if (_code == '000000') return true;
  //   setState(() {
  //     _errorCode = S.of(context).Wrong_authentication_code;
  //     _clearAuthenticationCode();
  //   });
  //   FocusScope.of(context).requestFocus(_codeFocus);
  //   return false;
  // }

  void _disappearError() {
    _errorName = '';
    _errorUsername = '';
    _errorPassword = '';
    _errorConfirmPassword = '';
    // _errorCode = '';
  }

  void _clearPassword(RegisterData data, [bool? clearPassword]) {
    var password = (clearPassword == true) ? data.getPassword() : '';
    BlocProvider.of<AuthenticationCubit>(context).register(
        RegisterData(data.getName(), data.getUsername(), password, ''));
    if (clearPassword != true) _passwordController.clear();
    _confirmPasswordController.clear();
  }

// void _clearAuthenticationCode() {
//   _authenticationCodeController.clear();
//   _code = '';
// }
}
