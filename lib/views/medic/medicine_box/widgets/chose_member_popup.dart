import 'dart:math';

import 'package:anthealth_mobile/blocs/medic/medicine_box_state.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class ChoseMemberPopup extends StatefulWidget {
  const ChoseMemberPopup(
      {Key? key, required this.personList, required this.done})
      : super(key: key);

  final List<MedicineBoxPerson> personList;
  final Function(List<bool>) done;

  @override
  State<ChoseMemberPopup> createState() => _ChoseMemberPopupState();
}

class _ChoseMemberPopupState extends State<ChoseMemberPopup> {
  List<bool> status = [];

  @override
  void initState() {
    for (MedicineBoxPerson x in widget.personList) status.add(x.isChose);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
            height: min(MediaQuery.of(context).size.height * 0.6,
                widget.personList.length * 54 + 40),
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                              children: widget.personList
                                  .map((person) => buildPersonComponent(
                                      person,
                                      context,
                                      widget.personList.indexOf(person)))
                                  .toList()))),
                  Divider(height: 1, color: AnthealthColors.black3),
                  buildButton(context)
                ])));
  }

  Widget buildPersonComponent(
      MedicineBoxPerson person, BuildContext context, int index) {
    return Container(
        height: 54,
        child: Column(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 4),
                  child: Row(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(person.avatarPath,
                            width: 30, height: 30, fit: BoxFit.cover)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(person.name,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline6),
                    ),
                    SizedBox(width: 8),
                    CommonButton.checkBox(
                        value: status[index],
                        onChanged: (value) => setState(() {
                              status[index] = value!;
                            }),
                        scale: 1.2)
                  ]))),
          CustomDivider.common()
        ]));
  }

  GestureDetector buildButton(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.done(status);
          Navigator.of(context).pop();
        },
        child: Container(
            color: Colors.transparent,
            height: 40,
            alignment: Alignment.center,
            child: Text(S.of(context).button_done,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: AnthealthColors.primary1))));
  }
}
