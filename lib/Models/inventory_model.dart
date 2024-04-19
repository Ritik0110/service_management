// To parse this JSON data, do
//
//     final inventoryModel = inventoryModelFromJson(jsonString);

import 'dart:convert';

InventoryModel inventoryModelFromJson(String str) => InventoryModel.fromJson(json.decode(str));

String inventoryModelToJson(InventoryModel data) => json.encode(data.toJson());

class InventoryModel {
  int result;
  String message;
  List<Datum> data;

  InventoryModel({
    required this.result,
    required this.message,
    required this.data,
  });

  factory InventoryModel.fromJson(Map<String, dynamic> json) => InventoryModel(
    result: json["Result"],
    message: json["Message"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Result": result,
    "Message": message,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String docNum;
  String docDate;
  String docStatus;
  String remark;

  Datum({
    required this.docNum,
    required this.docDate,
    required this.docStatus,
    required this.remark,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    docNum: json["DocNum"],
    docDate: json["DocDate"],
    docStatus: json["DocStatus"],
    remark: json["Remark"],
  );

  Map<String, dynamic> toJson() => {
    "DocNum": docNum,
    "DocDate": docDate,
    "DocStatus": docStatus,
    "Remark": remark,
  };
}
