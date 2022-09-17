import 'package:anthealth_mobile/blocs/health/calo_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/health/calo_models.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_snackbar.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCaloInBottomSheet extends StatefulWidget {
  const AddCaloInBottomSheet({
    Key? key,
    required this.superContext,
    required this.ok,
  }) : super(key: key);

  final BuildContext superContext;
  final Function(CaloIn) ok;

  @override
  _AddCaloInBottomSheetState createState() => _AddCaloInBottomSheetState();
}

class _AddCaloInBottomSheetState extends State<AddCaloInBottomSheet> {
  CaloIn data = CaloIn("", DateTime.now(), "", "", 0, 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
          padding: const EdgeInsets.all(12),
          child: Text(S.of(context).Add_calo_in,
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
                      data: caloInLabel(
                          BlocProvider.of<CaloCubit>(widget.superContext)
                              .getCaloIn()),
                      onChanged: (value) => setState(() {
                            data =
                                BlocProvider.of<CaloCubit>(widget.superContext)
                                    .getCaloIn()[caloInLabel(
                                        BlocProvider.of<CaloCubit>(
                                                widget.superContext)
                                            .getCaloIn())
                                    .indexOf(value!)];
                          })))
            ]),
            SizedBox(height: 16),
            if (data.name != "")
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Text(
                    S.of(context).Serving +
                        ": " +
                        data.servingName +
                        " | " +
                        data.servingCalo.toString() +
                        " calo/" +
                        S.of(context).serving,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle2),
                SizedBox(height: 16),
                Row(children: [
                  Text(S.of(context).Quantity,
                      style: Theme.of(context).textTheme.subtitle2),
                  SizedBox(width: 8),
                  SizedBox(
                      width: 100,
                      child: CommonTextField.box(
                          context: context,
                          textInputType:
                              TextInputType.numberWithOptions(decimal: true),
                          textAlign: TextAlign.end,
                          onChanged: (String value) => setState(() {
                                if (value == "")
                                  data.serving = 0;
                                else
                                  data.serving = double.parse(value);
                              }))),
                  SizedBox(width: 8),
                  Text(S.of(context).serving,
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
        if (data.serving > 0)
          widget.ok(data);
        else
          ShowSnackBar.showSuccessSnackBar(
              context, S.of(context).required_fill + '!');
        Navigator.of(context).pop();
      })
    ]);
  }

  List<String> caloInLabel(List<CaloIn> list) {
    List<String> result = [];
    for (CaloIn x in list) result.add(x.name);
    return result;
  }
}
