/*
 * @author kevin
 * @date 2021/4/3 14:19
 * @Description: flutter
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:super_train/app/module/home/controller/station_select_controller.dart';

class StationSelectPage extends GetView<StationSelectController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('车站选择'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: InputDecoration(
                  isDense: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1),
                  ),
                  labelText: '请输入车站名',
                ),
              ),
            ),
            Expanded(
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
                                width: 50,
                                height: 20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: HexColor('#edeff1'),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Text(
                                  '苏州',
                                  style: TextStyle(
                                    fontSize: 10,
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
                              onTap: (){
                                print(e.stationName);
                              },
                              child: Container(
                                width: 65,
                                height: 20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: HexColor('#edeff1'),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Text(
                                  '${e.stationName}',
                                  style: TextStyle(
                                    fontSize: 10,
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
            )
          ],
        ),
      ),
    );
  }
}
