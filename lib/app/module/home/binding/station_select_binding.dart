/*
 * @author kevin
 * @date 2021/4/3 14:52
 * @Description: flutter
*/

import 'package:get/get.dart';
import 'package:super_train/app/module/home/controller/station_select_controller.dart';

class StationSelectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StationSelectController());
  }
}
