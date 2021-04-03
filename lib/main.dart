import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:super_train/app/route/app_routes.dart';

import 'model/dog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      getPages: AppPages.getPages(),
      initialRoute: AppRoutes.HOME,
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
  int _counter = 0;

  void _incrementCounter() async {
    final Future<Database> database = openDatabase(
      // join(await getDatabasesPath(), 'doggie_database.db'),
      './super_train.db',
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        // return db.execute(
        //   "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
        // );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    final Database db = await database;
    debugPrint('52---main-----${db.path}');
// Create a Dog and add it to the dogs table.
    final dog = Dog(
      id: 0,
      name: 'Fido',
      age: 35,
    );

    // await insertDog(fido);

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    // await db.insert(
    //   'dogs',
    //   dog.toMap(),
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('station');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    final dogList = List.generate(maps.length, (i) {
      return Dog(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });

    debugPrint('83---main-----${dogList.length}');
    debugPrint('83---main');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
