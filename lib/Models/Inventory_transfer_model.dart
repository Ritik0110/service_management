// To parse this JSON data, do
//
//     final transferModel = transferModelFromJson(jsonString);

import 'dart:convert';

TransferModel transferModelFromJson(String str) => TransferModel.fromJson(json.decode(str));

String transferModelToJson(TransferModel data) => json.encode(data.toJson());

class TransferModel {
  DateTime docDate;
  List<StockTransferLine> stockTransferLines;

  TransferModel({
    required this.docDate,
    required this.stockTransferLines,
  });

  factory TransferModel.fromJson(Map<String, dynamic> json) => TransferModel(
    docDate: DateTime.parse(json["DocDate"]),
    stockTransferLines: List<StockTransferLine>.from(json["StockTransferLines"].map((x) => StockTransferLine.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "DocDate": "${docDate.year.toString().padLeft(4, '0')}-${docDate.month.toString().padLeft(2, '0')}-${docDate.day.toString().padLeft(2, '0')}",
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
