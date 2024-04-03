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
        serviceData!.add(ServiceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Result'] = result;
    data['Message'] = message;
    data['Count'] = count;
    if (serviceData != null) {
      data['Service_Data'] = serviceData!.map((v) => v.toJson()).toList();
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
  String? time;
  String? contactPerson;
  String? contactNumber;
  String? endDate;

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
        this.time,
        this.contactPerson,
        this.contactNumber,
        this.endDate});

  ServiceData.fromJson(Map<String, dynamic> json) {
    serviceCallNo = json['ServiceCallNo'];
    subject = json['Subject'];
    callStatus = json['CallStatus'];
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
    time = json['Time'];
    contactPerson = json['ContactPerson'];
    contactNumber = json['ContactNumber'];
    endDate = json['EndDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ServiceCallNo'] = serviceCallNo;
    data['Subject'] = subject;
    data['CallStatus'] = callStatus;
    data['Priority'] = priority;
    data['ProblemType'] = problemType;
    data['CallType'] = callType;
    data['CustomerCode'] = customerCode;
    data['CustomerName'] = customerName;
    data['IssueType'] = issueType;
    data['GenerateDate'] = generateDate;
    data['ItemCode'] = itemCode;
    data['ItemName'] = itemName;
    data['Address'] = address;
    data['Time'] = time;
    data['ContactPerson'] = contactPerson;
    data['ContactNumber'] = contactNumber;
    data['EndDate'] = endDate;
    return data;
  }
}
