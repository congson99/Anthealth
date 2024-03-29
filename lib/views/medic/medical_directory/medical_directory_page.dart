import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/midical_directory_logic.dart';
import 'package:anthealth_mobile/models/medic/medical_directory_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/medic/medical_directory/medical_contact_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalDirectoryPage extends StatefulWidget {
  const MedicalDirectoryPage({Key? key, required this.dashboardContext})
      : super(key: key);

  final BuildContext dashboardContext;

  @override
  State<MedicalDirectoryPage> createState() => _MedicalDirectoryPageState();
}

class _MedicalDirectoryPageState extends State<MedicalDirectoryPage> {
  List<MedicalDirectoryData> source = [];
  List<MedicalDirectoryAlphabetMarkData> data = [];
  ScrollController controller = ScrollController();
  FocusNode focusNode = FocusNode();
  bool showSearchBar = true;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DashboardCubit>(widget.dashboardContext)
        .getMedicalContacts()
        .then((value) => setState(() {
              source = value;
              data = MedicalDirectoryLogic.formatToMaskList(source);
            }));
    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        FocusScope.of(context).unfocus();
        setState(() => showSearchBar = true);
      }
      if (controller.position.userScrollDirection == ScrollDirection.reverse) {
        FocusScope.of(context).unfocus();
        setState(() => showSearchBar = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) => TemplateFormPage(
      title: S.of(context).Medical_directory,
      back: () => Navigator.of(context).pop(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      marginTop: 15,
      settings: () {},
      content: buildContent(context));

  // Content
  Widget buildContent(BuildContext context) => Container(
      height: MediaQuery.of(context).size.height - 109,
      child: Stack(children: [
        ListView.builder(
            controller: controller,
            itemBuilder: (context, i) {
              if (i == 0) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 104),
                      if (data.length == 0) SizedBox(height: 32),
                      if (data.length == 0) Text(S.of(context).No_data)
                    ]);
              }
              return buildContact(context, data[i - 1]);
            },
            itemCount: data.length + 1),
        AnimatedContainer(
            duration: Duration(milliseconds: 400),
            height: showSearchBar ? 112 : 0,
            color: Colors.white,
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Expanded(
                  child: CommonTextField.box(
                      hintText: S.of(context).Quick_lookup,
                      textColor: AnthealthColors.primary1,
                      textInputAction: TextInputAction.search,
                      onEditingComplete: () => FocusScope.of(context).unfocus(),
                      context: context,
                      maxLines: 1,
                      autofocus: false,
                      onChanged: (value) {
                        setState(() {
                          if (value != "")
                            data = MedicalDirectoryLogic.filter(source, value);
                          else
                            data =
                                MedicalDirectoryLogic.formatToMaskList(source);
                        });
                      }))
            ]))
      ]));

  Widget buildContact(
          BuildContext context, MedicalDirectoryAlphabetMarkData mask) =>
      GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => MedicalContactPage(contact: source[mask.index]))),
        child: Container(
            color: Colors.transparent,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (mask.mark)
                Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 10),
                    child: Text(
                        (mask.name.length != 0)
                            ? mask.name.substring(0, 1).toUpperCase()
                            : mask.highlight.substring(0, 1).toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: AnthealthColors.black2))),
              if (mask.mark) CustomDivider.common(),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(letterSpacing: 0.35),
                          children: <TextSpan>[
                            TextSpan(text: mask.name),
                            TextSpan(
                                text: mask.highlight,
                                style:
                                    TextStyle(color: AnthealthColors.primary1)),
                            TextSpan(text: mask.subName)
                          ]))),
              CustomDivider.common()
            ])),
      );
}
