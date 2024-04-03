class EmployeeModel {
  int? result;
  String? message;
  List<EmployeeData>? employeeData;

  EmployeeModel({this.result, this.message, this.employeeData});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    result = json['Result'];
    message = json['message'];
    if (json['Employee_Data'] != null) {
      employeeData = <EmployeeData>[];
      json['Employee_Data'].forEach((v) {
        employeeData!.add(EmployeeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Result'] = this.result;
    data['message'] = this.message;
    if (this.employeeData != null) {
      data['Employee_Data'] =
          this.employeeData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeeData {
  String? employeeCode;
  String? employeeId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? mobilePhone;
  String? eMail;

  EmployeeData(
      {this.employeeCode,
        this.employeeId,
        this.firstName,
        this.middleName,
        this.lastName,
        this.mobilePhone,
        this.eMail});

  EmployeeData.fromJson(Map<String, dynamic> json) {
    employeeCode = json['EmployeeCode'];
    employeeId = json['EmployeeId'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    mobilePhone = json['MobilePhone'];
    eMail = json['eMail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeCode'] = this.employeeCode;
    data['EmployeeId'] = this.employeeId;
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LastName'] = this.lastName;
    data['MobilePhone'] = this.mobilePhone;
    data['eMail'] = this.eMail;
    return data;
  }
}
