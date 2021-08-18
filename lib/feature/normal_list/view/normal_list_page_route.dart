import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glucose_counter/core/model/data_model.dart';
import 'package:glucose_counter/core/model/normal_list_enum.dart';
import 'package:glucose_counter/core/utils/text_themes.dart';
import 'package:glucose_counter/feature/normal_list/controller/normal_list_controller.dart';
import 'package:intl/intl.dart';

class NormalListPageRoute extends StatefulWidget {
  @override
  _NormalListPageRouteState createState() => _NormalListPageRouteState();
}

class _NormalListPageRouteState extends State<NormalListPageRoute>
    with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<NormalListController>(
      init: NormalListController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Glucose Values',
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
      NormalListEnum state, List<DataModel> data, String errorMessage) {
    if (state == NormalListEnum.loading)
      return Center(
        child: CircularProgressIndicator(),
      );
    else if (state == NormalListEnum.error)
      return Center(
        child: Text(errorMessage),
      );
    else {
      final formatter = DateFormat('yyyy-MM-dd hh:mm');
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Container(
                height: 48,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formatter.format(data[index].dateTime)),
                      Text(
                        data[index].value.toString() + ' mg/dL',
                        style: TextThemes.greenBold16,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
