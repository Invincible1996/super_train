/*
 * @author kevin
 * @date 2021/4/2 18:40
 * @Description: flutter
*/

class StationModel {
  int id;
  String stationName;
  String stationCode;

  StationModel({this.id, this.stationName, this.stationCode});

  StationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stationName = json['stationName'];
    stationCode = json['stationCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stationName'] = this.stationName;
    data['stationCode'] = this.stationCode;
    return data;
  }
}
