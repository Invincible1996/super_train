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
  static Future<List> copyDbFileToCacheDocument(String condition, int type) async {
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

    //从缓存目录读取db文件里面的数据
    return await queryData(condition, type);
  }

  //从缓存目录读取db文件里面的数据
  static Future<List> queryData(String condition, int type) async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'test.db');
    // open the database
    var db = await openDatabase(path);

    // Our database as a single table with a single element
    var dbList = [];
    List _list = [];
    if (type == 1) {
      dbList = await db.rawQuery("select * from  station where station_name like '%$condition%';");
      for (var item in dbList) {
        _list.add(StationModel(
          stationCode: item['station_code'],
          stationName: item['station_name'],
          id: item['id'],
        ));
      }
    } else if (type == 2) {
      dbList = await db.rawQuery(
          "select * from  train_detail where from_station_name like '%上海%' and to_station_name like '%苏州%';");
      for (var item in dbList) {
        _list.add(
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
    }
    print(dbList);
    await db.close();
    print('list $_list');
    print('list ${_list.length}');
    return _list;
  }
}
