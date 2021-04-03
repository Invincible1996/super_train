/*
 * @author kevin
 * @date 2021/4/3 11:38
 * @Description: flutter
*/

import 'package:get/get.dart';
import 'package:super_train/app/module/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
