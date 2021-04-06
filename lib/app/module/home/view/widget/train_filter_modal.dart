/*
 * @author kevin
 * @date 2021/4/5 16:16
 * @Description: flutter
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:super_train/app/module/home/controller/train_select_controller.dart';
import 'package:super_train/style/custom_color.dart';

class TrainFilterModal extends GetView<TrainSelectController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: CustomColor.colorDivide,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('重置'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('关闭'),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  '车次类型',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: controller.trainTypeList
                        .asMap()
                        .map(
                          (key, element) => MapEntry(
                            key,
                            StationCheckedItem(
                              isChecked: element.isChecked,
                              itemValue: element.stationName,
                              itemType: ItemType.TrainType,
                              index: key,
                            ),
                          ),
                        )
                        .values
                        .toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  '出发站',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(() => Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: controller.fromStationList
                          .asMap()
                          .map(
                            (key, element) => MapEntry(
                              key,
                              StationCheckedItem(
                                itemType: ItemType.FromStation,
                                isChecked: element.isChecked,
                                itemValue: element.stationName,
                                index: key,
                              ),
                            ),
                          )
                          .values
                          .toList(),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  '到达站',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(() => Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: controller.toStationList
                            .asMap()
                            .map(
                              (key, element) => MapEntry(
                                key,
                                StationCheckedItem(
                                  itemType: ItemType.ToStation,
                                  isChecked: element.isChecked,
                                  itemValue: element.stationName,
                                  index: key,
                                ),
                              ),
                            )
                            .values
                            .toList()),
                  )),
              SizedBox(
                height: 20,
              ),
            ],
          )),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(6.0),
                ),
              ),
              onPressed: () {
                controller.queryTainListByFilterCondition();
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                width: Get.width * .85,
                padding: EdgeInsets.symmetric(vertical: 10),
                // color: HexColor('#eae7fe'),
                child: Text(
                  '确 认',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class StationCheckedItem extends GetView<TrainSelectController> {
  final String itemValue;
  final bool isChecked;
  final ItemType itemType;
  final int index;

  const StationCheckedItem({
    Key key,
    this.itemType,
    this.index,
    @required this.itemValue,
    @required this.isChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(isChecked);
    return GestureDetector(
      onTap: () {
        controller.onStationItemChecked(index, itemValue, itemType);
      },
      child: Container(
        width: 65,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isChecked ? Colors.white : HexColor('#edeff1'),
            borderRadius: BorderRadius.circular(3),
            border: Border.all(
              color: isChecked ? CustomColor.primaryColor : Colors.transparent,
            )),
        child: Text(
          '$itemValue',
          style: TextStyle(
            fontSize: 12,
            color: isChecked ? CustomColor.primaryColor : Colors.black,
          ),
        ),
      ),
    );
  }
}

enum ItemType {
  FromStation,
  ToStation,
  TrainType,
}

class TrainFilterModel {
  bool isChecked;
  String stationName;

  TrainFilterModel({this.isChecked, this.stationName});
}
