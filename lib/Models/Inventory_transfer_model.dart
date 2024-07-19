// To parse this JSON data, do
//
//     final inventoryTransferModel = inventoryTransferModelFromJson(jsonString);

import 'dart:convert';

InventoryTransferModel inventoryTransferModelFromJson(String str) => InventoryTransferModel.fromJson(json.decode(str));

String inventoryTransferModelToJson(InventoryTransferModel data) => json.encode(data.toJson());

class InventoryTransferModel {
  DateTime docDate;
  String uCallid;
  String uAisitrsplit;
  String cardCode;
  List<StockTransferLine> stockTransferLines;

  InventoryTransferModel({
    required this.docDate,
    required this.uCallid,
    required this.uAisitrsplit,
    required this.cardCode,
    required this.stockTransferLines,
  });

  factory InventoryTransferModel.fromJson(Map<String, dynamic> json) => InventoryTransferModel(
    docDate: DateTime.parse(json["DocDate"]),
    uCallid: json["U_TEG_CALLID"],
    uAisitrsplit: json["U_AISITRSPLIT"],
    cardCode: json["CardCode"],
    stockTransferLines: List<StockTransferLine>.from(json["StockTransferLines"].map((x) => StockTransferLine.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "DocDate": "${docDate.year.toString().padLeft(4, '0')}-${docDate.month.toString().padLeft(2, '0')}-${docDate.day.toString().padLeft(2, '0')}",
    "U_TEG_CALLID": uCallid,
    "U_AISITRSPLIT": uAisitrsplit,
    "CardCode": cardCode,
    "StockTransferLines": List<dynamic>.from(stockTransferLines.map((x) => x.toJson())),
  };
}

class StockTransferLine {
  String itemCode;
  int quantity;
  String fromWarehouseCode;
  String warehouseCode;

  StockTransferLine({
    required this.itemCode,
    required this.quantity,
    required this.fromWarehouseCode,
    required this.warehouseCode,
  });

  factory StockTransferLine.fromJson(Map<String, dynamic> json) => StockTransferLine(
    itemCode: json["ItemCode"],
    quantity: json["Quantity"],
    fromWarehouseCode: json["FromWarehouseCode"],
    warehouseCode: json["WarehouseCode"],
  );

  Map<String, dynamic> toJson() => {
    "ItemCode": itemCode,
    "Quantity": quantity,
    "FromWarehouseCode": fromWarehouseCode,
    "WarehouseCode": warehouseCode,
  };
}
