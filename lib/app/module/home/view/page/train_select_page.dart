/*
 * @author kevin
 * @date 2021/4/4 09:55
 * @Description: flutter
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:super_train/app/module/home/controller/train_select_controller.dart';
import 'package:super_train/model/train_detail_model.dart';

class TrainSelectPage extends GetView<TrainSelectController> {
  @override
  Widget build(BuildContext context) {
    final title = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('$title'),
      ),
      body: Container(
        child: Obx(() {
          return ListView.builder(
              itemCount: controller.trainList.length,
              itemBuilder: (context, index) {
                TrainDetailModel model = controller.trainList[index];
                return Container(
                  margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: HexColor('#f6f7f8'),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.near_me,
                            size: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                '${model.fromStationName}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('${model.goTime}'),
                            ],
                          ),
                          Column(
                            children: [
                              Text('${model.trainNumber}'),
                              Icon(Icons.swap_horiz_sharp),
                              Text('${model.costTime}'),
                            ],
                          ),
                          Icon(
                            Icons.location_on,
                            size: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                '${model.toStationName}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${model.arriveTime}',
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        height: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('一等座：100'),
                          SizedBox(
                            width: 10,
                          ),
                          Text('二等座：200'),
                        ],
                      )
                    ],
                  ),
                );
              });
        }),
      ),
    );
  }
}
