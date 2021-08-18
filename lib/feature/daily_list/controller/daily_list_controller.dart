
import 'package:get/get.dart';
import 'package:glucose_counter/core/model/normal_list_enum.dart';
import 'package:glucose_counter/feature/daily_list/model/daily_list_model.dart';
import 'package:glucose_counter/feature/daily_list/repository/daily_list_repository.dart';

class DailyListController extends GetxController {
  var state = NormalListEnum.initial;
  var errorMessage = '';
  var dataList = <DailyListModel>[];
  final repository = DailyListRepository();

  @override
  void onInit() {
    _loadData();
    super.onInit();
  }

  void _loadData() async {
    state = NormalListEnum.loading;
    update();
    try {
      final temp = await repository.loadData();
      dataList = await repository.calculateDailyGlucose(temp);
      state = NormalListEnum.success;
    } catch (ex) {
      errorMessage = ex.toString();
      state = NormalListEnum.error;
    }
    update();
  }
}
