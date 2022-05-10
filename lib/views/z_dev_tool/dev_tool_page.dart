import 'dart:convert';

import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
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
  String sendData = "";
  List<String> result = ["", ""];
  FocusNode msgIDFocus = FocusNode();
  FocusNode dataFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: "DEV TOOL",
        back: () => Navigator.of(context).pop(),
        content:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          buildMessageIdArea(context),
          SizedBox(height: 24),
          buildSendDataArea(context),
          SizedBox(height: 24),
          CommonButton.round(
              context, () => sendMessage(), "Send", AnthealthColors.black2),
          SizedBox(height: 24),
          buildResultArea(context)
        ]));
  }

  Widget buildMessageIdArea(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text("Message ID", style: Theme.of(context).textTheme.subtitle2),
      SizedBox(height: 8),
      idFillBox(
          focusNode: msgIDFocus,
          onChanged: (String value) => setState(() {
                msgID = value;
                if (value.length == 4) dataFocus.requestFocus();
              }))
    ]);
  }

  Widget buildSendDataArea(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text("Send Data", style: Theme.of(context).textTheme.subtitle2),
      SizedBox(height: 12),
      dataFillBox(
          focusNode: dataFocus,
          onChanged: (value) => setState(() {
                sendData = value;
              }))
    ]);
  }

  Widget buildResultArea(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Result: " + result[0],
          style: Theme.of(context).textTheme.subtitle2),
      SizedBox(height: 8),
      if (result[0] == "loading...")
        Container(height: 24, width: 24, child: CupertinoActivityIndicator()),
      if (result[0] != "loading...")
        SelectableText(result[1], style: Theme.of(context).textTheme.bodyText1)
    ]);
  }

  Widget idFillBox(
      {required ValueChanged<String> onChanged, FocusNode? focusNode}) {
    return TextFormField(
        onChanged: onChanged,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AnthealthColors.black3, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AnthealthColors.black3, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(6)))),
        autofocus: true,
        style: Theme.of(context).textTheme.subtitle1);
  }

  Widget dataFillBox(
      {required ValueChanged<String> onChanged, FocusNode? focusNode}) {
    return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(6)),
            border: Border.all(color: AnthealthColors.black3, width: 0.5)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("{", style: Theme.of(context).textTheme.subtitle1),
          TextFormField(
              onChanged: onChanged,
              focusNode: focusNode,
              maxLines: null,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 16),
                border: InputBorder.none,
              ),
              autofocus: true,
              style: Theme.of(context).textTheme.subtitle1),
          Text("}", style: Theme.of(context).textTheme.subtitle1)
        ]));
  }

  void sendMessage() async {
    clear();
    if (!isFillRequired()) return;
    setState(() {
      result[0] = "loading...";
    });
    await CommonService.instance.send(int.parse(msgID), "{" + sendData + "}");
    await CommonService.instance.client!.getData().then((value) {
      setState(() {
        if (value == "null") {
          result[0] = "NULL DATA!";
          return;
        }
        result[0] = jsonDecode(value)["msgID"].toString();
        result[1] =
            JsonEncoder.withIndent('  ').convert(ServerLogic.getData(value));
      });
    });
  }

  bool isFillRequired() {
    if (msgID == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          content: Text("Message ID is required!")));
      setState(() => msgIDFocus.requestFocus());
      return false;
    }
    return true;
  }

  void clear() {
    ScaffoldMessenger.of(context).clearSnackBars();
    FocusScope.of(context).unfocus();
    result[1] = "";
  }
}
