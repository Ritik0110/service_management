// To parse this JSON data, do
//
//     final purchaseRequestModel = purchaseRequestModelFromJson(jsonString);

import 'dart:convert';

PurchaseRequestModel purchaseRequestModelFromJson(String str) => PurchaseRequestModel.fromJson(json.decode(str));

String purchaseRequestModelToJson(PurchaseRequestModel data) => json.encode(data.toJson());

class PurchaseRequestModel {
  DateTime requriedDate;
  String uCallid;
  List<DocumentLine> documentLines;

  PurchaseRequestModel({
    required this.requriedDate,
    required this.uCallid,
    required this.documentLines,
  });

  factory PurchaseRequestModel.fromJson(Map<String, dynamic> json) => PurchaseRequestModel(
    requriedDate: DateTime.parse(json["RequriedDate"]),
    uCallid: json["U_TEG_CALLID"],
    documentLines: List<DocumentLine>.from(json["DocumentLines"].map((x) => DocumentLine.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "RequriedDate": "${requriedDate.year.toString().padLeft(4, '0')}-${requriedDate.month.toString().padLeft(2, '0')}-${requriedDate.day.toString().padLeft(2, '0')}",
    "U_TEG_CALLID": uCallid,
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
