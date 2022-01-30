import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/theme/colors.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_line_chart.dart';
import 'package:anthealth_mobile/widgets/custom_appbar.dart';
import 'package:anthealth_mobile/widgets/switch_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndicatorPage extends StatefulWidget {
  const IndicatorPage(
      {Key? key,
      required this.indicatorIndex,
      required this.title,
      required this.unit,
      this.info})
      : super(key: key);

  final int indicatorIndex;
  final String title;
  final String unit;
  final String? info;

  @override
  _IndicatorPageState createState() => _IndicatorPageState();
}

class _IndicatorPageState extends State<IndicatorPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.only(top: 65),
            child: SingleChildScrollView(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: buildContent(context),
            )),
          ),
          CustomAppBar(
            title: widget.title,
            back: () => Navigator.pop(context),
            add: () {},
            settings: () {},
          )
        ]),
      ),
    );
  }

  Column buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(S.of(context).latest_record,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: AnthealthColors.black1)),
                  SizedBox(height: 8),
                  RichText(
                      text: TextSpan(
                          text: widget.indicatorIndex.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  fontSize: 48,
                                  color: AnthealthColors.primary1),
                          children: [
                        TextSpan(
                            text: widget.unit,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: AnthealthColors.primary1))
                      ])),
                  SizedBox(height: 8),
                  Text(S.of(context).record_time + ": 21.10.2021",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: AnthealthColors.black2)),
                  if (widget.info != null) SizedBox(height: 32),
                  if (widget.info != null)
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text("*" + widget.info!,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    color: AnthealthColors.black1,
                                    fontFamily: 'RobotoRegular',
                                    letterSpacing: 0)))
                ])),
        Container(
          decoration: BoxDecoration(
              color: AnthealthColors.primary5,
              borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SwitchBar(
                content: ["This year", "5 year", "All time"],
                index: _index,
                onIndexChange: (index) => setState(() => _index = index),
                colorID: 0,
              ),
              SizedBox(height: 32),
              IndicatorLineChart(filterIndex: 1, indicatorIndex: 0, data: [FlSpot(112, 160)],)
            ],
          ),
        )
      ],
    );
  }
}
