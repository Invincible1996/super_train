/*
 * @author kevin
 * @date 2021/4/4 15:19
 * @Description: flutter
*/

class TrainDetailModel {
  int id;
  String trainNumber;
  String fromStationCode;
  String fromStationName;
  String toStationCode;
  String toStationName;
  String goTime;
  String arriveTime;
  String costTime;
  String specialClassSeat;
  String firstClassSeat;
  String secondClassSeat;
  String softSleep;
  String hardSleep;
  String hardSeat;
  String noSeat;

  TrainDetailModel(
      {this.id,
      this.trainNumber,
      this.fromStationCode,
      this.fromStationName,
      this.toStationCode,
      this.toStationName,
      this.goTime,
      this.arriveTime,
      this.costTime,
      this.specialClassSeat,
      this.firstClassSeat,
      this.secondClassSeat,
      this.softSleep,
      this.hardSleep,
      this.hardSeat,
      this.noSeat});

  TrainDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trainNumber = json['train_number'];
    fromStationCode = json['from_station_code'];
    fromStationName = json['from_station_name'];
    toStationCode = json['to_station_code'];
    toStationName = json['to_station_name'];
    goTime = json['go_time'];
    arriveTime = json['arrive_time'];
    costTime = json['cost_time'];
    specialClassSeat = json['special_class_seat'];
    firstClassSeat = json['first_class_seat'];
    secondClassSeat = json['second_class_seat'];
    softSleep = json['soft_sleep'];
    hardSleep = json['hard_sleep'];
    hardSeat = json['hard_seat'];
    noSeat = json['no_seat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['train_number'] = this.trainNumber;
    data['from_station_code'] = this.fromStationCode;
    data['from_station_name'] = this.fromStationName;
    data['to_station_code'] = this.toStationCode;
    data['to_station_name'] = this.toStationName;
    data['go_time'] = this.goTime;
    data['arrive_time'] = this.arriveTime;
    data['cost_time'] = this.costTime;
    data['special_class_seat'] = this.specialClassSeat;
    data['first_class_seat'] = this.firstClassSeat;
    data['second_class_seat'] = this.secondClassSeat;
    data['soft_sleep'] = this.softSleep;
    data['hard_sleep'] = this.hardSleep;
    data['hard_seat'] = this.hardSeat;
    data['no_seat'] = this.noSeat;
    return data;
  }
}
