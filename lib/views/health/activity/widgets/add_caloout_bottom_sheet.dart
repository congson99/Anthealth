import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/health/calo_models.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_snackbar.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class AddCaloOutBottomSheet extends StatefulWidget {
  const AddCaloOutBottomSheet({
    Key? key,
    required this.superContext,
    required this.ok,
    required this.caloOutList,
  }) : super(key: key);

  final BuildContext superContext;
  final Function(CaloOut) ok;
  final List<CaloOut> caloOutList;

  @override
  _AddCaloOutBottomSheetState createState() => _AddCaloOutBottomSheetState();
}

class _AddCaloOutBottomSheetState extends State<AddCaloOutBottomSheet> {
  CaloOut data = CaloOut("", DateTime.now(), "", 0, 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
          padding: const EdgeInsets.all(12),
          child: Text(S.of(context).Add_calo_out,
              style: Theme.of(context).textTheme.subtitle1)),
      Divider(height: 0.5, thickness: 0.5, color: AnthealthColors.black3),
      Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(children: [
              Text(S.of(context).Select + ":  ",
                  style: Theme.of(context).textTheme.subtitle2),
              Expanded(
                  child: CommonTextField.select(
                      value: (data.name == "") ? null : data.name,
                      data: caloOutLabel(widget.caloOutList),
                      onChanged: (value) => setState(() {
                            data = widget.caloOutList[
                                caloOutLabel(widget.caloOutList)
                                    .indexOf(value!)];
                          })))
            ]),
            SizedBox(height: 16),
            if (data.name != "")
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Text(data.unitCalo.toString() + " calo/" + S.of(context).min,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle2),
                SizedBox(height: 16),
                Row(children: [
                  Text(S.of(context).Exercise,
                      style: Theme.of(context).textTheme.subtitle2),
                  SizedBox(width: 8),
                  SizedBox(
                      width: 100,
                      child: CommonTextField.box(
                          context: context,
                          textInputType: TextInputType.number,
                          onChanged: (String value) => setState(() {
                                if (value == "")
                                  data.min = 0;
                                else
                                  data.min = int.parse(value);
                              }))),
                  SizedBox(width: 8),
                  Text(S.of(context).min,
                      style: Theme.of(context).textTheme.subtitle1)
                ])
              ]),
            SizedBox(height: 32),
            buildButton(),
            SizedBox(
                height: EdgeInsets.fromWindowPadding(
                        WidgetsBinding.instance.window.viewInsets,
                        WidgetsBinding.instance.window.devicePixelRatio)
                    .bottom)
          ]))
    ])));
  }

  Widget buildButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      CommonButton.cancel(context, () => Navigator.of(context).pop()),
      CommonButton.add(context, () {
        if (data.min > 0)
          widget.ok(data);
        else
          ShowSnackBar.showErrorSnackBar(
              context, S.of(context).required_fill + '!');
        Navigator.of(context).pop();
      })
    ]);
  }

  List<String> caloOutLabel(List<CaloOut> list) {
    List<String> result = [];
    for (CaloOut x in list) result.add(x.name);
    return result;
  }
}
