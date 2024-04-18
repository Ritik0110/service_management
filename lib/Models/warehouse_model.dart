class WarehouseModel {
  int? result;
  String? message;
  List<WareHouse>? wareHouse;

  WarehouseModel({this.result, this.message, this.wareHouse});

  WarehouseModel.fromJson(Map<String, dynamic> json) {
    result = json['Result'];
    message = json['Message'];
    if (json['WareHouse'] != null) {
      wareHouse = <WareHouse>[];
      json['WareHouse'].forEach((v) {
        wareHouse!.add(new WareHouse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Result'] = this.result;
    data['Message'] = this.message;
    if (this.wareHouse != null) {
      data['WareHouse'] = this.wareHouse!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WareHouse {
  String? whsCode;
  String? whsName;

  WareHouse({this.whsCode, this.whsName});

  WareHouse.fromJson(Map<String, dynamic> json) {
    whsCode = json['WhsCode'];
    whsName = json['WhsName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WhsCode'] = this.whsCode;
    data['WhsName'] = this.whsName;
    return data;
  }
}
