/*
 * @author kevin
 * @date 2021/4/2 19:04
 * @Description: flutter
*/
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:super_train/model/station_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        buttonTheme: ButtonThemeData(height: 0, minWidth: 0),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Db Test Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<StationModel> _list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _list.length == 0
          ? Center(
              child: Container(
                child: Text("当前没有数据"),
              ),
            )
          : ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    "${_list[index].stationName}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  // subtitle: Text("${_list[index].stationCode}"),
                  trailing: Text("${_list[index].stationCode.toString()}"),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: _copyDbFileToCacheDocument,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  //将flutter路径下的db文件,copy到android/ios的 缓存目录下
  _copyDbFileToCacheDocument() async {
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
    var data = await rootBundle.load(join('assets', 'db', 'super_train.db'));

    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);

    //从缓存目录读取db文件里面的数据
    queryData();
  }

  //从缓存目录读取db文件里面的数据
  queryData() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'test.db');
    // open the database
    var db = await openDatabase(path);

    // Our database as a single table with a single element
    final dbList = await db.rawQuery('SELECT * FROM station');
    print(dbList);
    for (var item in dbList) {
      _list.add(StationModel(
        stationCode: item['station_code'],
        stationName: item['station_name'],
        id: item['id'],
      ));
    }
    setState(() {});
    print('list $_list');
    print('list ${_list.length}');

    await db.close();
  }

  openJsonFile() async {
    var data = await rootBundle.load(join('assets', 'dbfile', 'test.db'));
    print("--->data:$data");
  }
}
