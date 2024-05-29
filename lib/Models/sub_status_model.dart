class StatusModel {
  int? result;
  String? message;
  List<SubStatus>? subStatus;

  StatusModel({this.result, this.message, this.subStatus});

  StatusModel.fromJson(Map<String, dynamic> json) {
    result = json['Result'];
    message = json['Message'];
    if (json['SubStatus'] != null) {
      subStatus = <SubStatus>[];
      json['SubStatus'].forEach((v) {
        subStatus!.add(new SubStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Result'] = this.result;
    data['Message'] = this.message;
    if (this.subStatus != null) {
      data['SubStatus'] = this.subStatus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubStatus {
  String? subStatus;

  SubStatus({this.subStatus});

  SubStatus.fromJson(Map<String, dynamic> json) {
    subStatus = json['SubStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SubStatus'] = this.subStatus;
    return data;
  }
}
