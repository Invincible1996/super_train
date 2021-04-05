/*
 * @author kevin
 * @date 2021/4/4 10:05
 * @Description: flutter
*/

import 'package:get/get.dart';
import 'package:super_train/db/db_util.dart';

class TrainSelectController extends GetxController {
  var trainList = [].obs;

  @override
  void onInit() {
    super.onInit();
    String fromStation = Get.arguments['fromStation'];
    String toStation = Get.arguments['toStation'];
    queryTrainList(fromStation, toStation);
  }

  queryTrainList(String fromStation, String toStation) async {
    final list = await DbUtil.queryTrainDetailList(fromStation, toStation);
    trainList.assignAll(list);
  }
}
