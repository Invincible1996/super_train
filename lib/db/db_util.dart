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

class DbUtil {
  //将flutter路径下的db文件,copy到android/ios的 缓存目录下
  static Future<List<StationModel>> copyDbFileToCacheDocument(
      String condition) async {
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

    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);

    //从缓存目录读取db文件里面的数据
    return await queryData(condition);
  }

  //从缓存目录读取db文件里面的数据
  static Future<List<StationModel>> queryData(String condition) async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'test.db');
    // open the database
    var db = await openDatabase(path);

    // Our database as a single table with a single element
    final dbList = await db.rawQuery(
        "select * from  station where station_name like '%$condition%';");
    print(dbList);
    await db.close();
    List<StationModel> _list = [];
    for (var item in dbList) {
      _list.add(StationModel(
        stationCode: item['station_code'],
        stationName: item['station_name'],
        id: item['id'],
      ));
    }
    print('list $_list');
    print('list ${_list.length}');
    return _list;
  }
}
