/*
 * @author kevin
 * @date 2021/4/3 13:41
 * @Description: flutter
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:super_train/app/module/home/view/widget/current_station_item.dart';
import 'package:super_train/app/route/app_routes.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#f5f5f0'),
      appBar: AppBar(
        title: Text('站站查询'),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CurrentStationItem(
                  onTapItem: ()=>Get.toNamed(AppRoutes.STATION_SELECT),
                  title: '出发站',
                  station: '上海虹桥站',
                ),
                Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    alignment: Alignment.center,
                    child: IconButton(
                        icon: Icon(Icons.switch_left), onPressed: () {})),
                CurrentStationItem(
                  onTapItem: ()=>Get.toNamed(AppRoutes.STATION_SELECT),
                  title: '目的站',
                  station: '北京南站',
                ),
              ],
            ),
            Container(
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
                      Text('4月3日'),
                      Text('周六'),
                    ],
                  ),
                  Icon(Icons.arrow_right_outlined),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {},
              child: Container(
                alignment: Alignment.center,
                width: 200,
                child: Text('查询'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
