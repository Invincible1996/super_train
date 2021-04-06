/*
 * @author kevin
 * @date 2021/4/4 10:05
 * @Description: flutter
*/

import 'package:get/get.dart';
import 'package:super_train/app/module/home/view/widget/train_filter_modal.dart';
import 'package:super_train/db/db_util.dart';
import 'package:super_train/model/train_detail_model.dart';

import 'home_controller.dart';

class TrainSelectController extends GetxController {
  /// 车次集合
  var trainList = [].obs;

  /// 出发站集合
  var fromStationList = [].obs;

  /// 到达站集合
  var toStationList = [].obs;

  ///车次类型集合
  var trainTypeList = [].obs;

  @override
  void onInit() {
    super.onInit();
    String fromStation = Get.arguments['fromStation'];
    String toStation = Get.arguments['toStation'];
    queryTrainList(fromStation, toStation);
    trainTypeList.assignAll(['高铁/动车', '普通车']);
  }

  queryTrainList(
    String fromStation,
    String toStation,
  ) async {
    final list = await DbUtil.queryTrainDetailList(
      fromStation,
      toStation,
    );
    for (var item in list) {
      if (!fromStationList.contains(item.fromStationName)) {
        fromStationList.add(item.fromStationName);
      }
    }
    for (var item in list) {
      if (!toStationList.contains(item.toStationName)) {
        toStationList.add(item.toStationName);
      }
    }
    var newFromStationList = fromStationList
        .map((element) => TrainFilterModel(
              isChecked: false,
              stationName: element,
            ))
        .toList();
    var newToStationList = toStationList
        .map((element) => TrainFilterModel(
              isChecked: false,
              stationName: element,
            ))
        .toList();

    var newTrainTypeList = trainTypeList
        .map(
          (element) => TrainFilterModel(
            isChecked: false,
            stationName: element,
          ),
        )
        .toList();

    trainTypeList.assignAll(newTrainTypeList);
    toStationList.assignAll(newToStationList);
    fromStationList.assignAll(newFromStationList);

    trainList.assignAll(list);
  }

  ///
  void onStationItemChecked(int index, String itemValue, ItemType itemType) {
    switch (itemType) {
      case ItemType.FromStation:
        {
          var newList = [];
          for (var i = 0; i < fromStationList.length; i++) {
            if (i == index) {
              newList.add(TrainFilterModel(
                  stationName: fromStationList[i].stationName,
                  isChecked: !fromStationList[i].isChecked));
            } else {
              newList.add(TrainFilterModel(
                  stationName: fromStationList[i].stationName,
                  isChecked: fromStationList[i].isChecked));
            }
          }
          fromStationList.assignAll(newList);
        }
        break;
      case ItemType.ToStation:
        {
          var newList = [];
          for (var i = 0; i < toStationList.length; i++) {
            if (i == index) {
              newList.add(TrainFilterModel(
                  stationName: toStationList[i].stationName,
                  isChecked: !toStationList[i].isChecked));
            } else {
              newList.add(TrainFilterModel(
                  stationName: toStationList[i].stationName,
                  isChecked: toStationList[i].isChecked));
            }
          }
          toStationList.assignAll(newList);
        }
        break;
      case ItemType.TrainType:
        print(trainTypeList);
        var newList = [];
        for (var i = 0; i < trainTypeList.length; i++) {
          if (i == index) {
            newList.add(TrainFilterModel(
                stationName: trainTypeList[i].stationName, isChecked: !trainTypeList[i].isChecked));
          } else {
            newList.add(TrainFilterModel(
                stationName: trainTypeList[i].stationName, isChecked: trainTypeList[i].isChecked));
          }
        }
        trainTypeList.assignAll(newList);
        break;
    }
  }

  /// @desc 根据筛选条件查询
  queryTainListByFilterCondition() async {
    ///
    final selectTypeList = trainTypeList.where((item) => item.isChecked).toList();
    print(selectTypeList);

    final selectToStationList = toStationList.where((item) => item.isChecked).toList();

    final selectFromStationList = fromStationList.where((item) => item.isChecked).toList();

    HomeController homeController = Get.find<HomeController>();

    List<TrainDetailModel> selectTrainList = await DbUtil.queryTrainDetailList(
      homeController.fromStation.value,
      homeController.toStation.value,
      traintypeList: selectTypeList,
      toStationList: selectToStationList,
      fromStationList: selectFromStationList,
    );
    trainList.assignAll(selectTrainList);
  }
}
