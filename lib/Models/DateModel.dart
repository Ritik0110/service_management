class DateModel {
  DateModel({
      num? result, 
      String? message, 
      List<Dates>? dates,}){
    _result = result;
    _message = message;
    _dates = dates;
}

  DateModel.fromJson(dynamic json) {
    _result = json['Result'];
    _message = json['Message'];
    if (json['Dates'] != null) {
      _dates = [];
      json['Dates'].forEach((v) {
        _dates?.add(Dates.fromJson(v));
      });
    }
  }
  num? _result;
  String? _message;
  List<Dates>? _dates;

  num? get result => _result;
  String? get message => _message;
  List<Dates>? get dates => _dates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Result'] = _result;
    map['Message'] = _message;
    if (_dates != null) {
      map['Dates'] = _dates?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Dates {
  Dates({
      String? dates,}){
    _dates = dates;
}

  Dates.fromJson(dynamic json) {
    _dates = json['Dates'];
  }
  String? _dates;

  String? get dates => _dates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Dates'] = _dates;
    return map;
  }

}