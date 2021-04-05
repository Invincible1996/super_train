/*
 * @author kevin
 * @date 2021/4/3 14:51
 * @Description: flutter
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_train/db/db_util.dart';
import 'package:super_train/model/station_model.dart';

class StationSelectController extends GetxController {
  /// 热门车站
  List<StationModel> hotStationList = [
    StationModel(stationName: '苏州', stationCode: 'SZH', id: 1),
    StationModel(stationName: '南京南', stationCode: 'NKH', id: 1),
    StationModel(stationName: '上海虹桥', stationCode: 'AOH', id: 1),
    StationModel(stationName: '北京南', stationCode: 'VNP', id: 289),
    StationModel(stationName: '上海', stationCode: 'VNP', id: 289),
  ];

  /// 查询的车站
  RxList<StationModel> selectList = <StationModel>[].obs;

  TextEditingController textEditingController = new TextEditingController();
  FocusNode focusNode = FocusNode();
  RxBool isFocus = false.obs;

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() {
      debugPrint("Focus: " + focusNode.hasFocus.toString());
      isFocus.value = focusNode.hasFocus;
    });
  }

  /// 根据名称查询
  queryStationByValue(String condition) async {
    List<StationModel> stationList =
        await DbUtil.queryStationList(condition);
    print(stationList);
    selectList.assignAll(stationList);
  }
}
