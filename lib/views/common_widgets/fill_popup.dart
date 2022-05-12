import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class FillPopup extends StatefulWidget {
  const FillPopup(
      {Key? key,
      required this.title,
      required this.fillBoxes,
      required this.done})
      : super(key: key);

  final String title;
  final List<String> fillBoxes;
  final Function(List<String>) done;

  @override
  State<FillPopup> createState() => _FillPopupState();
}

class _FillPopupState extends State<FillPopup> {
  List<List<String>> data = [];

  @override
  void initState() {
    for (int i = 0; i < widget.fillBoxes.length; i++)
      data.add([i.toString(), ""]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: EdgeInsets.symmetric(horizontal: 16),
        child: Container(
            height: 120 + widget.fillBoxes.length * 110,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildTitle(context),
                  Expanded(
                      child:
                          SingleChildScrollView(child: buildContent(context))),
                  Divider(height: 1, color: AnthealthColors.black3),
                  buildButton(context)
                ])));
  }

  // Content Component
  Widget buildTitle(BuildContext context) {
    return Column(children: [
      SizedBox(height: 8),
      Text(widget.title, style: Theme.of(context).textTheme.subtitle1),
      SizedBox(height: 8),
      Divider(height: 1, color: AnthealthColors.black3)
    ]);
  }

  Widget buildContent(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
            children: data
                .map((box) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.fillBoxes[int.parse(box[0])],
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: AnthealthColors.black2)),
                          SizedBox(height: 8),
                          CommonTextField.box(
                              context: context,
                              initialValue: box[1],
                              onChanged: (String value) => setState(() {
                                    data[int.parse(box[0])][1] = value;
                                  })),
                          SizedBox(height: 16)
                        ]))
                .toList()));
  }

  Widget buildButton(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
              color: Colors.transparent,
              height: 40,
              alignment: Alignment.center,
              child: Text(S.of(context).button_cancel,
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: AnthealthColors.warning1)))),
      Container(width: 1, height: 40, color: AnthealthColors.black4),
      GestureDetector(
          onTap: () => done(),
          child: Container(
              color: Colors.transparent,
              height: 40,
              alignment: Alignment.center,
              child: Text(S.of(context).button_done,
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: AnthealthColors.primary1))))
    ]);
  }

  // Actions
  void done() {
    List<String> result = [];
    for (List<String> x in data) result.add(x[1]);
    Navigator.of(context).pop();
    widget.done(result);
  }
}
