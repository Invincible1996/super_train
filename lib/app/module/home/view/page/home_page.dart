/*
 * @author kevin
 * @date 2021/4/3 13:41
 * @Description: flutter
*/

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:super_train/app/module/home/controller/home_controller.dart';
import 'package:super_train/app/module/home/view/widget/current_station_item.dart';
import 'package:super_train/app/route/app_routes.dart';
import 'package:super_train/style/custom_color.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#f5f5f5'),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '站站查询',
                          style: GoogleFonts.maShanZheng(
                            textStyle: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${DateUtil.formatDate(DateTime.now(), format: 'yyyy年MM月dd日')}  ${DateUtil.getWeekday(DateTime.now(), languageCode: 'zh')}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            color: HexColor('#eae7fe'), borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                          Icons.wb_sunny,
                          color: CustomColor.primaryColor,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: CustomColor.primaryColor, borderRadius: BorderRadius.circular(6)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => CurrentStationItem(
                        iconData: Icons.near_me,
                        onTapItem: () => Get.toNamed(
                          AppRoutes.STATION_SELECT,
                          arguments: '出发站',
                        ),
                        title: '出发站',
                        station: controller.fromStation.value,
                      ),
                    ),
                    Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        alignment: Alignment.center,
                        child: IconButton(
                            icon: Icon(
                              Icons.swap_horiz_sharp,
                              color: Colors.white,
                              size: 26,
                            ),
                            onPressed: () {
                              final temp1 = controller.fromStation.value;
                              final temp2 = controller.toStation.value;
                              controller.setFromStation(temp2);
                              controller.setToStation(temp1);
                            })),
                    Obx(
                      () => CurrentStationItem(
                        iconData: Icons.location_on,
                        onTapItem: () => Get.toNamed(
                          AppRoutes.STATION_SELECT,
                          arguments: '目的站',
                        ),
                        title: '目的站',
                        station: controller.toStation.value,
                      ),
                    )
                  ],
                ),
              ),
              Obx(() => GestureDetector(
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
                        controller.setDate(selectDate);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                  '${DateUtil.formatDate(controller.selectDate.value, format: 'MM月dd日')}'),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                  '${DateUtil.getWeekday(controller.selectDate.value, languageCode: 'zh')}'),
                            ],
                          ),
                          Icon(Icons.arrow_right_outlined),
                        ],
                      ),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // primary: HexColor('#eae7fe'), // background
                  // onPrimary: HexColor('#eae7fe'),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(6.0),
                  ),
                ),
                onPressed: () {
                  print('${controller.fromStation}---${controller.toStation}');
                  Get.toNamed(
                    AppRoutes.TRAIN_SELECT,
                    arguments: {
                      'fromStation': controller.fromStation.value,
                      'toStation': controller.toStation.value,
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  width: Get.width,
                  // color: HexColor('#eae7fe'),
                  child: Text(
                    '查询',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
