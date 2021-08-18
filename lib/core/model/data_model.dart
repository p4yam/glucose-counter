import 'package:flutter/foundation.dart';

class DataModel {
  final DateTime dateTime;
  final DateTime dateTimeDaily;
  final int value;

  DataModel(
      {@required this.dateTime,
      @required this.value,
      @required this.dateTimeDaily});

  factory DataModel.fromMap(dynamic data) {
    final dateString = data[0];
    final year = dateString.substring(6, 10);
    final day = dateString.substring(0, 2);
    return DataModel(
        dateTime: DateTime.parse(
            dateString.replaceRange(0, 2, year).replaceRange(8, 12, day)),
        dateTimeDaily: DateTime.parse(dateString
            .replaceRange(0, 2, year)
            .replaceRange(8, 12, day)
            .toString()
            .split(' ')[0]),
        value: data[1]);
  }
}
