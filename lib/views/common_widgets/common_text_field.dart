import 'dart:async';

import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonTextField {
  CommonTextField._();

  static Widget round(
          {required BuildContext context,
          required ValueChanged<String> onChanged,
          String? hintText,
          String? labelText,
          String? errorText,
          FocusNode? focusNode,
          TextEditingController? textEditingController,
          bool? isVisibility}) =>
      TextField(
          onChanged: onChanged,
          focusNode: focusNode,
          controller: textEditingController,
          decoration: InputDecoration(
            errorText: errorText,
            labelText: labelText,
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide:
                    BorderSide(color: AnthealthColors.primary1, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide:
                    BorderSide(color: AnthealthColors.primary1, width: 1)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide:
                    BorderSide(color: AnthealthColors.warning1, width: 1)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide:
                    BorderSide(color: AnthealthColors.warning1, width: 1)),
          ),
          obscureText: (isVisibility == true) ? true : false,
          style: Theme.of(context).textTheme.subtitle1,
          textInputAction: TextInputAction.done);
}
