/*
 * @author kevin
 * @date 2021/4/2 18:53
 * @Description: flutter
*/
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

import 'package:super_train/model/station_model.dart';


class DictionaryDataBaseHelper {
  Database _db;

  Future<void> init() async {
    io.Directory applicationDirectory =
    await getApplicationDocumentsDirectory();

    String dbPathEnglish =
    path.join(applicationDirectory.path, "super_train.db");

    bool dbExistsEnglish = await io.File(dbPathEnglish).exists();

    if (!dbExistsEnglish) {
      // Copy from asset
      ByteData data = await rootBundle.load(path.join("assets", "super_train.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(dbPathEnglish).writeAsBytes(bytes, flush: true);
    }

    this._db = await openDatabase(dbPathEnglish);
  }

  /// get all the words from english dictionary
  Future<List<StationModel>> getAllTheWordsEnglish() async {
    if (_db == null) {
      throw "bd is not initiated, initiate using [init(db)] function";
    }
    List<Map> words;

    await _db.transaction((txn) async {
      words = await txn.query(
        "words",
        columns: [
          "en_word",
          "en_definition",
        ],
      );
    });

    return words.map((e) => StationModel.fromJson(e)).toList();
  }
}