/*
 * @author kevin
 * @date 2021/4/3 14:19
 * @Description: flutter
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:super_train/app/module/home/controller/home_controller.dart';
import 'package:super_train/app/module/home/controller/station_select_controller.dart';
import 'package:super_train/style/custom_color.dart';

class StationSelectPage extends GetView<StationSelectController> {
  @override
  Widget build(BuildContext context) {
    final appBarTitle = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('$appBarTitle'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                focusNode: controller.focusNode,
                onChanged: (value) {
                  /// 查询
                  if (value.isNotEmpty) {
                    print(value);
                    controller.queryStationByValue(value);
                  }
                },
                decoration: InputDecoration(
                  isDense: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: CustomColor.primaryColor, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: CustomColor.primaryColor, width: 1),
                  ),
                  labelText: '请输入车站名',
                ),
              ),
            ),
            Obx(() {
              return controller.isFocus.isTrue ||
                      controller.selectList.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: controller.selectList.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            HomeController homeController =
                                Get.find<HomeController>();
                            if (appBarTitle == '出发站') {
                              homeController.setFromStation(
                                  controller.selectList[index].stationName);
                            } else {
                              homeController.setToStation(
                                  controller.selectList[index].stationName);
                            }
                            Get.back();
                          },
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 15, right: 15, top: 10),
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            child: Text(
                                '${controller.selectList[index].stationName}'),
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 15),
                        child: ListView(
                          children: [
                            Text('最近常用'),
                            SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              children: List.generate(
                                  5,
                                  (index) => Container(
                                    width: 65,
                                    height: 25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: HexColor('#edeff1'),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Text(
                                          '苏州',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                      )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('热门车站'),
                            SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              children: controller.hotStationList
                                  .map(
                                    (e) => GestureDetector(
                                      onTap: () {
                                        HomeController homeController =
                                            Get.find<HomeController>();
                                        if (appBarTitle == '出发站') {
                                          homeController
                                              .setFromStation(e.stationName);
                                        } else {
                                          homeController
                                              .setToStation(e.stationName);
                                        }
                                        Get.back();
                                      },
                                      child: Container(
                                        width: 65,
                                        height: 25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: HexColor('#edeff1'),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Text(
                                          '${e.stationName}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    );
            })
          ],
        ),
      ),
    );
  }
}
