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
import 'package:super_train/style/custom_color.dart';

class TrainSelectPage extends GetView<TrainSelectController> {
  @override
  Widget build(BuildContext context) {
    final fromStation = Get.arguments['fromStation'];
    final toStation = Get.arguments['toStation'];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('$fromStation<>$toStation'),
      ),
      body: Container(
        child: Obx(() {
          return Column(
            children: [
              Container(
                height: 45,
                color: CustomColor.primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.arrow_left,
                          color: Colors.white,
                        ),
                        onPressed: () {}),
                    Container(
                      width: 70,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(6)),
                      child: Text('4月4日'),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
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
                                  Expanded(
                                    child: Icon(
                                      Icons.near_me,
                                      size: 20,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Text(
                                          '${model.fromStationName}',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${model.goTime}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: CustomColor.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Text(
                                          '${model.trainNumber}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(Icons.arrow_right_alt),
                                        Text('${model.costTime}'),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Icon(
                                      Icons.location_on,
                                      size: 20,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Text(
                                          '${model.toStationName}',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${model.arriveTime}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: CustomColor.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
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
                      }))
            ],
          );
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          Get.bottomSheet(
            Container(
              height: 500,
              color: Colors.white,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: List.generate(
                          2,
                          (index) => Container(
                                width: 65,
                                height: 25,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: HexColor('#edeff1'),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Text(
                                  '高铁/动车',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              )),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: List.generate(
                          3,
                          (index) => Container(
                                width: 65,
                                height: 25,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: HexColor('#edeff1'),
                                  borderRadius: BorderRadius.circular(3),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      '到达站',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: List.generate(
                          2,
                          (index) => Container(
                                width: 65,
                                height: 25,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: HexColor('#edeff1'),
                                  borderRadius: BorderRadius.circular(3),
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: HexColor('#eae7fe'), // background
                        // onPrimary: HexColor('#eae7fe'),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(6.0),
                        ),
                      ),
                      onPressed: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: Get.width * .85,
                        // color: HexColor('#eae7fe'),
                        child: Text(
                          '确 认',
                          style: TextStyle(
                            color: CustomColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_alt_outlined),
            label: '筛选',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: '耗时最短',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm_sharp),
            label: '发时最早',
          ),
        ],
      ),
    );
  }
}
