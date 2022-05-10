import 'dart:convert';

import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DevToolPage extends StatefulWidget {
  const DevToolPage({Key? key}) : super(key: key);

  @override
  State<DevToolPage> createState() => _DevToolPageState();
}

class _DevToolPageState extends State<DevToolPage> {
  String msgID = "";
  String sendData = "{\n\t\n}";
  String result = "";
  FocusNode msgIDFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: "DEV TOOL",
        back: () => Navigator.of(context).pop(),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildMessageIdArea(context),
            SizedBox(height: 24),
            buildSendDataArea(context),
            SizedBox(height: 24),
            CommonButton.round(
                context, () => sendMessage(), "Send", AnthealthColors.black2),
            SizedBox(height: 24),
            buildResultArea(context)
          ],
        ));
  }

  Widget buildMessageIdArea(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text("Message ID", style: Theme.of(context).textTheme.subtitle2),
      SizedBox(height: 8),
      fillBox(
          isNumber: true,
          focusNode: msgIDFocus,
          onChanged: (String value) => setState(() {
                msgID = value;
              })),
    ]);
  }

  Widget buildSendDataArea(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text("Send Data", style: Theme.of(context).textTheme.subtitle2),
      SizedBox(height: 12),
      fillBox(
          initialValue: sendData,
          onChanged: (value) => setState(() {
                sendData = value;
              }))
    ]);
  }

  Widget buildResultArea(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Result:", style: Theme.of(context).textTheme.subtitle2),
      SizedBox(height: 8),
      if (result == "waiting")
        Container(height: 24, width: 24, child: CupertinoActivityIndicator()),
      if (result != "waiting")
        SelectableText(result, style: Theme.of(context).textTheme.bodyText1)
    ]);
  }

  Widget fillBox(
      {required ValueChanged<String> onChanged,
      String? labelText,
      String? initialValue,
      bool? isNumber,
      FocusNode? focusNode}) {
    return TextFormField(
        onChanged: onChanged,
        focusNode: focusNode,
        initialValue: initialValue,
        maxLines: null,
        keyboardType:
            (isNumber == true) ? TextInputType.number : null,
        decoration: InputDecoration(
            labelText: labelText,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AnthealthColors.black3, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AnthealthColors.primary2, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(6)))),
        autofocus: true,
        style: Theme.of(context).textTheme.subtitle1);
  }

  void sendMessage() async {
    ScaffoldMessenger.of(context).clearSnackBars();
    if (msgID == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          content: Text("Message ID is required!")));
      setState(() => msgIDFocus.requestFocus());
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      result = "waiting";
    });
    await CommonService.instance.send(int.parse(msgID), sendData);
    await CommonService.instance.client!.getData().then((value) {
      setState(() {
        if (value == "null") {
          result = "NULL DATA!";
          return;
        }
        result = "Message ID: " + jsonDecode(value)["msgID"].toString() + "\n";
        result += "Message Data: " + ServerLogic.getData(value).toString();
      });
    });
  }
}
