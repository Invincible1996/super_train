import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:super_train/app/route/app_routes.dart';
import 'package:super_train/style/custom_color.dart';

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
        primarySwatch: CustomColor.primaryColor,
        // fontFamily: 'Anton',
      ),
      getPages: AppPages.getPages(),
      initialRoute: AppRoutes.HOME,
    );
  }
}
