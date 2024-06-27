class InventoryModel {
  int? result;
  String? message;
  List<Data>? data;

  InventoryModel({this.result, this.message, this.data});

  InventoryModel.fromJson(Map<String, dynamic> json) {
    result = json['Result'];
    message = json['Message'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Result'] = this.result;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? docNum;
  String? docDate;
  String? reqDate;
  String? remark;
  List<ItemData>? itemData;

  Data({this.docNum, this.docDate, this.reqDate, this.remark, this.itemData});

  Data.fromJson(Map<String, dynamic> json) {
    docNum = json['DocNum'];
    docDate = json['DocDate'];
    reqDate = json['ReqDate'];
    remark = json['Remark'];
    if (json['ItemData'] != null) {
      itemData = <ItemData>[];
      json['ItemData'].forEach((v) {
        itemData!.add(new ItemData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocNum'] = this.docNum;
    data['DocDate'] = this.docDate;
    data['ReqDate'] = this.reqDate;
    data['Remark'] = this.remark;
    if (this.itemData != null) {
      data['ItemData'] = this.itemData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemData {
  String? itemCode;
  String? description;
  double? quantity;

  ItemData({this.itemCode, this.description, this.quantity});

  ItemData.fromJson(Map<String, dynamic> json) {
    itemCode = json['ItemCode'];
    description = json['Description'];
    quantity = json['Quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemCode'] = this.itemCode;
    data['Description'] = this.description;
    data['Quantity'] = this.quantity;
    return data;
  }
}
