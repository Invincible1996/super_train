/*
 * @author kevin
 * @date 2021/4/3 11:11
 * @Description: flutter
*/

import 'package:get/get.dart';
import 'package:super_train/app/module/home/binding/home_binding.dart';
import 'package:super_train/app/module/home/binding/station_select_binding.dart';
import 'package:super_train/app/module/home/view/page/home_page.dart';
import 'package:super_train/app/module/home/view/page/station_select_page.dart';

class AppRoutes {
  static const String HOME = '/home';
  static const String STATION_SELECT = '/stationSelect';
}

abstract class AppPages {
  static getPages() => [
        GetPage(
            name: AppRoutes.HOME,
            page: () => HomePage(),
            binding: HomeBinding()),
        GetPage(
          name: AppRoutes.STATION_SELECT,
          page: () => StationSelectPage(),
          binding: StationSelectBinding(),
        )
      ];
}
