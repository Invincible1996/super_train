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
    queryTrainList();
  }

  queryTrainList() async {
    final list = await DbUtil.copyDbFileToCacheDocument('', 2);
    trainList.assignAll(list);
  }
}
