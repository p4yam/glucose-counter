
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:glucose_counter/core/model/data_model.dart';

class NormalListRepository{

  Future<List<DataModel>> loadData()async{
    final myData = await  rootBundle.loadString('assets/files/values.csv');
    final rawData = const CsvToListConverter().convert(myData);
    rawData.removeAt(0);
    return rawData.map((e) => DataModel.fromMap(e)).toList();
  }
}