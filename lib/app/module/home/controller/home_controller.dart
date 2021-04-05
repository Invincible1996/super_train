/*
 * @author kevin
 * @date 2021/4/3 11:15
 * @Description: flutter
*/

import 'package:get/get.dart';
import 'package:super_train/db/db_util.dart';

class HomeController extends GetxController {
  RxString fromStation = '上海虹桥'.obs;
  RxString toStation = '苏州'.obs;

  @override
  void onInit() {
    super.onInit();

    /// 拷贝数据 到缓存目录
    DbUtil.copyDbFileToCacheDocument();
  }

  setFromStation(String value) {
    fromStation.value = value;
  }

  setToStation(String value) {
    toStation.value = value;
  }
}
