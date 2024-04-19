// To parse this JSON data, do
//
//     final purchaseModel = purchaseModelFromJson(jsonString);

import 'dart:convert';

PurchaseModel purchaseModelFromJson(String str) => PurchaseModel.fromJson(json.decode(str));

String purchaseModelToJson(PurchaseModel data) => json.encode(data.toJson());

class PurchaseModel {
  DateTime requriedDate;
  List<DocumentLine> documentLines;

  PurchaseModel({
    required this.requriedDate,
    required this.documentLines,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) => PurchaseModel(
    requriedDate: DateTime.parse(json["RequriedDate"]),
    documentLines: List<DocumentLine>.from(json["DocumentLines"].map((x) => DocumentLine.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "RequriedDate": "${requriedDate.year.toString().padLeft(4, '0')}-${requriedDate.month.toString().padLeft(2, '0')}-${requriedDate.day.toString().padLeft(2, '0')}",
    "DocumentLines": List<dynamic>.from(documentLines.map((x) => x.toJson())),
  };
}

class DocumentLine {
  String itemCode;
  int quantity;
  String warehouseCode;

  DocumentLine({
    required this.itemCode,
    required this.quantity,
    required this.warehouseCode,
  });

  factory DocumentLine.fromJson(Map<String, dynamic> json) => DocumentLine(
    itemCode: json["ItemCode"],
    quantity: json["Quantity"],
    warehouseCode: json["WarehouseCode"],
  );

  Map<String, dynamic> toJson() => {
    "ItemCode": itemCode,
    "Quantity": quantity,
    "WarehouseCode": warehouseCode,
  };
}
