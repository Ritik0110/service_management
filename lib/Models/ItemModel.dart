class ItemModel {
  int? result;
  String? message;
  List<ItemData>? itemData;

  ItemModel({this.result, this.message, this.itemData});

  ItemModel.fromJson(Map<String, dynamic> json) {
    result = json['Result'];
    message = json['Message'];
    if (json['Item_Data'] != null) {
      itemData = <ItemData>[];
      json['Item_Data'].forEach((v) {
        itemData!.add(ItemData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Result'] = result;
    data['Message'] = message;
    if (itemData != null) {
      data['Item_Data'] = itemData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemData {
  String? itemCode;
  String? itemName;
  String? groupCode;
  String? groupName;
  num? quantity;

  ItemData(
      {this.itemCode,
        this.itemName,
        this.groupCode,
        this.groupName,
        this.quantity});

  ItemData.fromJson(Map<String, dynamic> json) {
    itemCode = json['ItemCode'];
    itemName = json['ItemName'];
    groupCode = json['GroupCode'];
    groupName = json['GroupName'];
    quantity = json['Quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ItemCode'] = itemCode;
    data['ItemName'] = itemName;
    data['GroupCode'] = groupCode;
    data['GroupName'] = groupName;
    data['Quantity'] = quantity;
    return data;
  }
}
