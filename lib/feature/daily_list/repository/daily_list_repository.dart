import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:glucose_counter/core/model/data_model.dart';
import 'package:glucose_counter/feature/daily_list/model/daily_list_model.dart';

class DailyListRepository {
  Future<List<DataModel>> loadData() async {
    final myData = await rootBundle.loadString('assets/files/values.csv');
    final rawData = const CsvToListConverter().convert(myData);
    rawData.removeAt(0);
    return rawData.map((e) => DataModel.fromMap(e)).toList();
  }

  Future<List<DailyListModel>> calculateDailyGlucose(
      List<DataModel> data) async {
    final Map<DateTime, DailyListModel> dataMap = {};
    data.forEach((element) {
      if (dataMap.containsKey(element.dateTimeDaily)) {
        dataMap[element.dateTimeDaily].glucoseValues.add(element.value);
        dataMap[element.dateTimeDaily].dateTime.add(element.dateTime);
      } else {
        dataMap[element.dateTimeDaily] = DailyListModel(
            dateDay: element.dateTimeDaily,
            glucoseValues: [element.value],
            dateTime: [element.dateTime]);
      }
    });

    return dataMap.values
        .map((e) => DailyListModel(
            dateDay: e.dateDay,
            glucoseValues: e.glucoseValues,
            dateTime: e.dateTime,
            numPicks: _calculateNumPicks(e),
            rangePercent: ((e.glucoseValues
                            .where((x) => (x >= 80 && x <= 110))
                            .toList()
                            .length /
                        e.glucoseValues.length) *
                    100)
                .round()))
        .toList();
  }

  int _calculateNumPicks(DailyListModel model) {
    var result = 0;
    for (int i = 0; i < model.glucoseValues.length - 1; i++) {
      if (model.dateTime[i + 1].difference(model.dateTime[i]).inMinutes <= 15 &&
          (model.glucoseValues[i + 1] - model.glucoseValues[i] > 20))
        result += 1;
    }
    return result;
  }
}
