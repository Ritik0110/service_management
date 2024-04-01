//sample data

// {
// "resultFlag": 1,
// "data": [
// {
// "id": "405514",
// "date": "01-04-2024",
// "title": "Computer Not Working",
// "time": "01:30 PM",
// "priority": "High",
// "location": "Gitschiner Str., Berlin Germeany",
// "status": "Open"
// }
// ]
// }


class TicketsModel {
  int? resultFlag;
  List<Data>? data;

  TicketsModel({this.resultFlag, this.data});

  TicketsModel.fromJson(Map<String, dynamic> json) {
    resultFlag = json['resultFlag'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultFlag'] = this.resultFlag;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? date;
  String? title;
  String? time;
  String? priority;
  String? location;
  String? status;

  Data(
      {this.id,
        this.date,
        this.title,
        this.time,
        this.priority,
        this.location,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    title = json['title'];
    time = json['time'];
    priority = json['priority'];
    location = json['location'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['title'] = this.title;
    data['time'] = this.time;
    data['priority'] = this.priority;
    data['location'] = this.location;
    data['status'] = this.status;
    return data;
  }
}
