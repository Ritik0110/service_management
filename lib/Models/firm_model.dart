class FirmModel {
  FirmModel({
      num? result, 
      String? message, 
      List<ListFirm>? listFirm,}){
    _result = result;
    _message = message;
    _listFirm = listFirm;
}

  FirmModel.fromJson(dynamic json) {
    _result = json['Result'];
    _message = json['Message'];
    if (json['List_Firm'] != null) {
      _listFirm = [];
      json['List_Firm'].forEach((v) {
        _listFirm?.add(ListFirm.fromJson(v));
      });
    }
  }
  num? _result;
  String? _message;
  List<ListFirm>? _listFirm;

  num? get result => _result;
  String? get message => _message;
  List<ListFirm>? get listFirm => _listFirm;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Result'] = _result;
    map['Message'] = _message;
    if (_listFirm != null) {
      map['List_Firm'] = _listFirm?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ListFirm {
  ListFirm({
      String? firmName,}){
    _firmName = firmName;
}

  ListFirm.fromJson(dynamic json) {
    _firmName = json['FirmName'];
  }
  String? _firmName;

  String? get firmName => _firmName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['FirmName'] = _firmName;
    return map;
  }

}