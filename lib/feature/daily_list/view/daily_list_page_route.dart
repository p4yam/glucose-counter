import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glucose_counter/core/model/normal_list_enum.dart';
import 'package:glucose_counter/core/utils/app_colors.dart';
import 'package:glucose_counter/core/utils/text_themes.dart';
import 'package:glucose_counter/feature/daily_list/controller/daily_list_controller.dart';
import 'package:glucose_counter/feature/daily_list/model/daily_list_model.dart';
import 'package:glucose_counter/feature/daily_list/widget/custom_list_widget.dart';
import 'package:glucose_counter/feature/daily_list/widget/percentage_widget.dart';

class DailyListPageRoute extends StatefulWidget {
  @override
  _DailyListPageRouteState createState() => _DailyListPageRouteState();
}

class _DailyListPageRouteState extends State<DailyListPageRoute>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<DailyListController>(
      init: DailyListController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Daily Values',
              style: TextThemes.blackNormal19,
            ),
          ),
          body: _buildBody(
              controller.state, controller.dataList, controller.errorMessage),
        );
      },
    );
  }

  Widget _buildBody(
      NormalListEnum state, List<DailyListModel> data, String errorMessage) {
    if (state == NormalListEnum.loading)
      return Center(
        child: CircularProgressIndicator(),
      );
    else if (state == NormalListEnum.error)
      return Center(
        child: Text(errorMessage),
      );
    else {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PercentageWidget(
                    percentage: data[index].rangePercent,
                  ),
                  Text(data[index].numPicks.toString(),
                      style: TextThemes.blackNormal20.copyWith(
                          color: data[index].numPicks == 0
                              ? AppColor.GrayDarker
                              : AppColor.RedAccent))
                ],
              ),
              CustomListWidget(
                dailyListModel: data[index],
              )
            ],
          );
        },
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
