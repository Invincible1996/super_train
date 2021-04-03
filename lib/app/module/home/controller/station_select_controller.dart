/*
 * @author kevin
 * @date 2021/4/3 14:51
 * @Description: flutter
*/

import 'package:get/get.dart';
import 'package:super_train/model/station_model.dart';

class StationSelectController extends GetxController {
  List<StationModel> hotStationList = [
    StationModel(stationName: '苏州', stationCode: 'SZH', id: 1),
    StationModel(stationName: '南京南', stationCode: 'NKH', id: 1),
    StationModel(stationName: '上海虹桥', stationCode: 'AOH', id: 1),
    StationModel(stationName: '北京南', stationCode: 'VNP', id: 289),
  ];

  @override
  void onInit() {
    super.onInit();
  }
}
