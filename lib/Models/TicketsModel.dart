class TicketsModel {
  int? result;
  String? message;
  int? count;
  List<ServiceData>? serviceData;

  TicketsModel({this.result, this.message, this.count, this.serviceData});

  TicketsModel.fromJson(Map<String, dynamic> json) {
    result = json['Result'];
    message = json['Message'];
    count = json['Count'];
    if (json['Service_Data'] != null) {
      serviceData = <ServiceData>[];
      json['Service_Data'].forEach((v) {
        serviceData!.add(new ServiceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Result'] = this.result;
    data['Message'] = this.message;
    data['Count'] = this.count;
    if (this.serviceData != null) {
      data['Service_Data'] = this.serviceData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceData {
  String? serviceCallNo;
  String? subject;
  String? callStatus;
  String? priority;
  String? problemType;
  String? callType;
  String? customerCode;
  String? customerName;
  String? issueType;
  String? generateDate;
  String? itemCode;
  String? itemName;
  String? address;
  String? model;
  String? manuSN;
  String? endDate;
  String? time;
  String? contactPerson;
  String? contactNumber;
  String? subStatus;

  ServiceData(
      {this.serviceCallNo,
        this.subject,
        this.callStatus,
        this.priority,
        this.problemType,
        this.callType,
        this.customerCode,
        this.customerName,
        this.issueType,
        this.generateDate,
        this.itemCode,
        this.itemName,
        this.address,
        this.model,
        this.manuSN,
        this.endDate,
        this.time,
        this.contactPerson,
        this.subStatus,
        this.contactNumber});

  ServiceData.fromJson(Map<String, dynamic> json) {
    serviceCallNo = json['ServiceCallNo'];
    subject = json['Subject'];
    callStatus = json['CallStatus'];
    subStatus = json['SubStatus'];
    priority = json['Priority'];
    problemType = json['ProblemType'];
    callType = json['CallType'];
    customerCode = json['CustomerCode'];
    customerName = json['CustomerName'];
    issueType = json['IssueType'];
    generateDate = json['GenerateDate'];
    itemCode = json['ItemCode'];
    itemName = json['ItemName'];
    address = json['Address'];
    model = json['Model'];
    manuSN = json['ManuSN'];
    endDate = json['EndDate'];
    time = json['Time'];
    contactPerson = json['ContactPerson'];
    contactNumber = json['ContactNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ServiceCallNo'] = this.serviceCallNo;
    data['Subject'] = this.subject;
    data['SubStatus'] = this.subStatus;
    data['CallStatus'] = this.callStatus;
    data['Priority'] = this.priority;
    data['ProblemType'] = this.problemType;
    data['CallType'] = this.callType;
    data['CustomerCode'] = this.customerCode;
    data['CustomerName'] = this.customerName;
    data['IssueType'] = this.issueType;
    data['GenerateDate'] = this.generateDate;
    data['ItemCode'] = this.itemCode;
    data['ItemName'] = this.itemName;
    data['Address'] = this.address;
    data['Model'] = this.model;
    data['ManuSN'] = this.manuSN;
    data['EndDate'] = this.endDate;
    data['Time'] = this.time;
    data['ContactPerson'] = this.contactPerson;
    data['ContactNumber'] = this.contactNumber;
    return data;
  }
}
