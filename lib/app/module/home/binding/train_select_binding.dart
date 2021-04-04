/*
 * @author kevin
 * @date 2021/4/4 10:04
 * @Description: flutter
*/

import 'package:get/get.dart';
import 'package:super_train/app/module/home/controller/train_select_controller.dart';

class TrainSelectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainSelectController());
  }
}
