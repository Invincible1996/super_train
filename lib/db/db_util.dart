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
    List traintypeList,
    List fromStationList,
    List toStationList,
  }) async {
    traintypeList ??= [];
    fromStationList ??= [];
    toStationList ??= [];

    final db = await openLocalDatabase();
    List<TrainDetailModel> trainDetailList = [];
    String fromStationFilterString = "'";
    String toStationFilterString = "'";

    // if (fromStationList.length == 1) {
    //   fromStationFilterString = '${fromStationList[0].stationName}';
    // } else {
    //   for (int i = 0; i < fromStationList.length; i++) {
    //     if (i == fromStationList.length - 1) {
    //       fromStationFilterString += "'${fromStationList[i].stationName}'";
    //     } else {
    //       fromStationFilterString += "'${fromStationList[i].stationName},";
    //     }
    //   }
    // }

    for (var i = 0; i < fromStationList.length; i++) {
      fromStationFilterString +=
          i != fromStationList.length - 1 ? "${fromStationList[i].stationName}','" : "${fromStationList[i].stationName}'";
    }

    for (var i = 0; i < toStationList.length; i++) {
      toStationFilterString +=
      i != toStationList.length - 1 ? "${toStationList[i].stationName}','" : "${toStationList[i].stationName}'";
    }

    print(fromStationFilterString);
    print(toStationFilterString);

    var fromStationFilterSql =
        fromStationList.isNotEmpty ? "and from_station_name in ($fromStationFilterString)" : '';
    var toStationFilterSql =
        toStationList.isNotEmpty ? "and to_station_name in ($toStationFilterString)" : '';

    var querySql =
        "select *from train_detail where from_station_name like '%$fromStation%'and to_station_name like '%$toStation%'"
        "$fromStationFilterSql"
        "$toStationFilterSql;";
    print(querySql);
    var dbList = await db.rawQuery(querySql);
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
