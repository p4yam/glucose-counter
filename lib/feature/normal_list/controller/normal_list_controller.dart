
import 'package:get/get.dart';
import 'package:glucose_counter/core/model/data_model.dart';
import 'package:glucose_counter/core/model/normal_list_enum.dart';
import 'package:glucose_counter/feature/normal_list/repository/normal_list_repository.dart';

class NormalListController extends GetxController {
  final NormalListRepository repository = NormalListRepository();
  var state = NormalListEnum.initial;
  var errorMessage = '';
  var dataList = <DataModel>[];

  @override
  void onInit() {
    _loadData();
    super.onInit();
  }

  void _loadData() async {
    state = NormalListEnum.loading;
    update();
    try {
      dataList = await repository.loadData();
      dataList.sort((first, second) => second.value.compareTo(first.value));
      state = NormalListEnum.success;
    } catch (ex) {
      errorMessage = ex.toString();
      state = NormalListEnum.error;
    }
    update();
  }
}
