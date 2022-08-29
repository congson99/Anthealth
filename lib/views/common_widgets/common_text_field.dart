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
      TextInputType? textInputType,
      FocusNode? focusNode,
      bool? readOnly,
      TextInputAction? textInputAction,
      TextEditingController? textEditingController,
      bool? isVisibility}) {
    return TextField(
        onChanged: onChanged,
        focusNode: focusNode,
        readOnly: readOnly ?? false,
        controller: textEditingController,
        keyboardType: textInputType,
        obscureText: isVisibility ?? false,
        style: Theme.of(context).textTheme.subtitle1,
        textInputAction: textInputAction ?? TextInputAction.done,
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
        ));
  }

  static Widget fill(
      {required BuildContext context,
      required ValueChanged<String> onChanged,
      VoidCallback? onTap,
      String? hintText,
      String? labelText,
      FocusNode? focusNode,
      TextInputAction? textInputAction,
      bool? readOnly,
      String? initialValue,
      TextEditingController? textEditingController}) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly ?? false,
      onChanged: onChanged,
      focusNode: focusNode,
      textInputAction: textInputAction,
      initialValue: initialValue,
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
            borderSide: BorderSide(color: AnthealthColors.black2, width: 0.5)),
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
  }

  static Widget box(
      {required BuildContext context,
      required ValueChanged<String> onChanged,
      VoidCallback? onTap,
      String? hintText,
      FocusNode? focusNode,
      bool? readOnly,
      String? initialValue,
      bool? autofocus,
      TextAlign? textAlign,
      TextInputAction? textInputAction,
      TextInputType? textInputType,
      int? maxLines,
      Color? textColor,
      EdgeInsets? padding,
      Function()? onEditingComplete,
      TextEditingController? textEditingController}) {
    return TextFormField(
        onTap: onTap,
        readOnly: readOnly ?? false,
        onChanged: onChanged,
        focusNode: focusNode,
        initialValue: initialValue,
        controller: textEditingController,
        textInputAction: textInputAction ?? TextInputAction.done,
        textAlign: textAlign ?? TextAlign.start,
        onEditingComplete: onEditingComplete,
        keyboardType: textInputType,
        maxLines: maxLines,
        autofocus: autofocus ?? false,
        style:
            Theme.of(context).textTheme.subtitle1!.copyWith(color: textColor),
        decoration: InputDecoration(
          labelStyle: CommonText.fillLabelTextStyle(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: AnthealthColors.black2),
          filled: true,
          fillColor: Colors.white,
          contentPadding: padding ?? EdgeInsets.all(16),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AnthealthColors.black3, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AnthealthColors.primary2, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AnthealthColors.warning1, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          focusedErrorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AnthealthColors.warning1, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(12))),
        ));
  }

  static Widget select(
      {required List<String> data,
      String? labelText,
      String? value,
      required ValueChanged<String?> onChanged}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (labelText != null)
        Text(labelText,
            style: CommonText.fillLabelTextStyle()
                .copyWith(fontSize: 11, color: Colors.black.withOpacity(0.6))),
      DropdownButton<String>(
          menuMaxHeight: 500,
          isExpanded: true,
          underline: Container(height: 0.5, color: AnthealthColors.black2),
          value: value,
          items: data.map<DropdownMenuItem<String>>((String mValue) {
            return DropdownMenuItem<String>(
                value: mValue,
                child: mValue == value
                    ? Text(mValue)
                    : Text(mValue,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: AnthealthColors.black2)));
          }).toList(),
          onChanged: (value) => onChanged(value))
    ]);
  }

  static Widget selectBox(
      {required List<String> data,
      String? value,
      FocusNode? focusNode,
      required ValueChanged<String?> onChanged}) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AnthealthColors.black3, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
                menuMaxHeight: 500,
                isExpanded: true,
                focusNode: focusNode,
                value: value,
                items: data.map<DropdownMenuItem<String>>((String mValue) {
                  return DropdownMenuItem<String>(
                      value: mValue,
                      child: mValue == value
                          ? Text(mValue, overflow: TextOverflow.ellipsis)
                          : Text(mValue,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: AnthealthColors.black2)));
                }).toList(),
                onChanged: (value) => onChanged(value))));
  }
}
