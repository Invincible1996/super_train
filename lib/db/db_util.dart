/*
 * @author kevin
 * @date 2021/4/3 21:59
 * @Description: flutter
*/

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:super_train/model/station_model.dart';
import 'package:super_train/model/train_detail_model.dart';

class DbUtil {
  //将flutter路径下的db文件,copy到android/ios的 缓存目录下
  static copyDbFileToCacheDocument() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'test.db');

    // delete existing if any
    await deleteDatabase(path);

    // Make sure the parent directory exists
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    // var data = await rootBundle.load(join('assets/dbfile/test.db'));
    var data = await rootBundle.load(
      join('assets', 'db', 'super_train.db'),
    );

    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);
  }

  //从缓存目录读取db文件里面的数据
  static Future<Database> openLocalDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'test.db');
    return await openDatabase(path);
  }

  /// 查询所有车站
  static Future<List<StationModel>> queryStationList(String condition) async {
    final db = await openLocalDatabase();
    List<StationModel> stationList = [];
    var dbList =
        await db.rawQuery("select * from  station where station_name like '%$condition%';");
    for (var item in dbList) {
      stationList.add(StationModel(
        stationCode: item['station_code'],
        stationName: item['station_name'],
        id: item['id'],
      ));
    }
    return stationList;
  }

  /// 根据车站查询车次详情
  static Future<List<TrainDetailModel>> queryTrainDetailList(
    String fromStation,
    String toStation, {
    trainType,
    List<String> fromStationList,
    List<String> toStationList,
  }) async {
    final db = await openLocalDatabase();
    List<TrainDetailModel> trainDetailList = [];
    String fromStationFilterString = "from_station_name = '' ";
    String toStationFilterString = "to_station_name=";
    // for (var item in fromStationList) {
    //   fromStationFilterString += "'$item'or from_station_name=";
    // }

    // if(fromStationList.isNotEmpty) fromStationFilterString = '';
    // if(toStationList.isNotEmpty) toStationFilterString = '';

    for (int i = 0; i < fromStationList.length; i++) {
      if (i == fromStationList.length - 1) {
        fromStationFilterString += "'${fromStationList[i]}'";
      } else {
        fromStationFilterString += "'${fromStationList[i]}'or from_station_name=";
      }
    }

    for (int i = 0; i < toStationList.length; i++) {
      if (i == toStationList.length - 1) {
        toStationFilterString += "'${toStationList[i]}'";
      } else {
        toStationFilterString += "'${toStationList[i]}'or to_station_name=";
      }
    }

    print(fromStationFilterString);
    print(toStationFilterString);

    var querySql = "select * from  train_detail where from_station_name like '%$fromStation%'"
        "and to_station_name like '%$toStation%' "
        "and $fromStationFilterString "
        "and $toStationFilterString;";
    print(querySql);
    var dbList = await db
        .rawQuery("select * from  train_detail where from_station_name like '%$fromStation%'"
            "and to_station_name like '%$toStation%';");
    for (var item in dbList) {
      trainDetailList.add(
        TrainDetailModel(
          fromStationCode: item['from_station_code'],
          fromStationName: item['from_station_name'],
          toStationCode: item['to_station_code'],
          toStationName: item['to_station_name'],
          arriveTime: item['arrive_time'],
          goTime: item['go_time'],
          costTime: item['cost_time'],
          id: item['id'],
          trainNumber: item['train_number'].toString(),
        ),
      );
    }
    return trainDetailList;
  }

  /// 根据条件筛选

}
