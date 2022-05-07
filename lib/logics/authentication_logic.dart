import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthenticationLogic {
  static dynamic emailError(BuildContext context, String email) {
    if (email == '') return S.of(context).Enter_email;
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) return S.of(context).Invalid_email;
    return null;
  }

  static dynamic passwordError(BuildContext context, String password) {
    if (password == '') return S.of(context).Enter_password;
    if (password.length < 8) return S.of(context).Invalid_password;
    return null;
  }

  static dynamic confirmPasswordError(BuildContext context, String password) {
    if (password == '') return S.of(context).Enter_confirm_password;
    if (password.length < 8) return S.of(context).Invalid_password;
    return null;
  }
}
