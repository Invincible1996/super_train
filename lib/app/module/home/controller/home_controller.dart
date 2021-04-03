/*
 * @author kevin
 * @date 2021/4/3 11:15
 * @Description: flutter
*/

import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString fromStation = '上海虹桥'.obs;
  RxString toStation = '苏州'.obs;

  @override
  void onInit() {
    super.onInit();
  }

  setFromStation(String value) {
    fromStation.value = value;
  }

  setToStation(String value) {
    toStation.value = value;
  }
}
