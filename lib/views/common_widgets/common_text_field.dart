import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';

class CommonTextField {
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
          autofocus: true,
          style: Theme.of(context).textTheme.subtitle1,
          textInputAction: TextInputAction.done);

  static Widget fill(
          {required BuildContext context,
          required ValueChanged<String> onChanged,
          VoidCallback? onTap,
          String? hintText,
          String? labelText,
          FocusNode? focusNode,
          TextEditingController? textEditingController}) =>
      TextFormField(
        onTap: onTap,
        onChanged: onChanged,
        focusNode: focusNode,
        controller: textEditingController,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: CommonText.fillLabelTextStyle(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: AnthealthColors.black2),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(0),
          enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: AnthealthColors.black2, width: 0.5)),
          focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: AnthealthColors.primary2, width: 0.5)),
          errorBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: AnthealthColors.warning1, width: 0.5)),
          focusedErrorBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: AnthealthColors.warning1, width: 0.5)),
        ),
        autofocus: true,
        style: Theme.of(context).textTheme.subtitle1,
      );

  static Widget select(
          {required List<String> data,
          required String labelText,
          String? value,
          FocusNode? focusNode,
          required ValueChanged<String?> onChanged}) =>
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(labelText,
                style: CommonText.fillLabelTextStyle().copyWith(
                    fontSize: 11, color: Colors.black.withOpacity(0.6))),
            DropdownButton<String>(
                menuMaxHeight: 500,
                isExpanded: true,
                focusNode: focusNode,
                underline:
                    Container(height: 0.5, color: AnthealthColors.black2),
                value: value,
                items: data.map<DropdownMenuItem<String>>((String mValue) {
                  return DropdownMenuItem<String>(
                      value: mValue,
                      child: mValue == value
                          ? Text(mValue)
                          : Text(mValue,
                              style: TextStyle(color: AnthealthColors.black2)));
                }).toList(),
                onChanged: (value) => onChanged(value))
          ]);
}
