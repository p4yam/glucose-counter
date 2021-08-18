import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glucose_counter/core/utils/app_colors.dart';
import 'package:glucose_counter/core/utils/text_themes.dart';
import 'package:glucose_counter/feature/daily_list/model/daily_list_model.dart';
import 'package:glucose_counter/feature/daily_list/widget/custom_line_chart.dart';
import 'package:intl/intl.dart';

class CustomListWidget extends StatefulWidget {
  CustomListWidget({Key key,this.dailyListModel}) : super(key: key);
  final DailyListModel dailyListModel;
  @override
  _CustomListWidgetState createState() => _CustomListWidgetState();
}

class _CustomListWidgetState extends State<CustomListWidget> {
  var _detailVisibility=false;
  var _chartVisibility=false;
  final formatter = DateFormat('yyyy-MM-dd hh:mm');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Date: '+formatter.format(widget.dailyListModel.dateDay),style: TextThemes.blackNormal16,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: MaterialButton(
                        child: Text(_detailVisibility?'Hide Detail':'Show Detail'),
                        color: AppColor.GrayLight,
                        onPressed: () {
                          setState(() {
                            setState(() {
                              _detailVisibility=!_detailVisibility;
                            });
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
                      child: MaterialButton(
                        child: Text(_chartVisibility?'Hide Chart':'Show Chart'),
                        color: AppColor.GrayLight,
                        onPressed: () {
                          setState(() {
                            setState(() {
                              _chartVisibility=!_chartVisibility;
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Visibility(
                    visible: _chartVisibility,
                    child: CustomLineChart(data: widget.dailyListModel.glucoseValues,)),
                Visibility(
                  visible: _detailVisibility,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.dailyListModel.glucoseValues.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? AppColor.GrayLighter
                                  : AppColor.White),
                          child: Padding(
                            padding:
                            const EdgeInsets.only(left: 12, right: 12),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(formatter.format(widget.dailyListModel.dateTime[index])),
                                Text(
                                  '${widget.dailyListModel.glucoseValues[index]} mg/dL',
                                  style: TextThemes.greenBold16,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}