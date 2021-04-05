/*
 * @author kevin
 * @date 2021/4/4 09:55
 * @Description: flutter
*/
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:super_train/app/module/home/controller/home_controller.dart';
import 'package:super_train/app/module/home/controller/train_select_controller.dart';
import 'package:super_train/app/module/home/view/widget/train_filter_modal.dart';
import 'package:super_train/app/widget/common_app_bar.dart';
import 'package:super_train/model/train_detail_model.dart';
import 'package:super_train/style/custom_color.dart';

class TrainSelectPage extends GetView<TrainSelectController> {
  @override
  Widget build(BuildContext context) {
    final fromStation = Get.arguments['fromStation'];
    final toStation = Get.arguments['toStation'];
    HomeController homeController = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: HexColor('#f5f5f5'),
      appBar: CommonAppBar(
        title: '$fromStation<>$toStation',
        elevation: 0,
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
                    GestureDetector(
                      onTap: () async {
                        DateTime selectDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(
                            2021,
                            5,
                            30,
                          ),
                        );

                        print(selectDate);
                        if (selectDate != null) {
                          homeController.setDate(selectDate);
                        }
                      },
                      child: Container(
                        width: 70,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          '${DateUtil.formatDate(homeController.selectDate.value, format: 'MM月dd日')}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        final nowDate = DateTime.now();
                        int year = nowDate.year;
                        int month = nowDate.month;
                        int day = nowDate.day;
                        print('$year$month$day');
                      },
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
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
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
                              // Row(
                              //   children: [
                              //     Text('一等座：100'),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     Text('二等座：200'),
                              //   ],
                              // )
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
          if (index == 0) {
            Get.bottomSheet(TrainFilterModal());
          }
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
