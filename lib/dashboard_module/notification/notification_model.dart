class NotiFicationModel2 {
  NotiFicationModel2({
    this.status,
    this.response,
    this.notifications,});

  NotiFicationModel2.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'];
    if (json['notifications'] != null) {
      notifications = [];
      json['notifications'].forEach((v) {
        notifications?.add(Notifications.fromJson(v));
      });
    }
  }
  String? status;
  String? response;
  List<Notifications>? notifications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['response'] = response;
    if (notifications != null) {
      map['notifications'] = notifications?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Notifications {
  Notifications({
    this.title,
    this.content,
    this.time,});

  Notifications.fromJson(dynamic json) {
    title = json['title'];
    content = json['content'];
    time = json['time'];
  }
  String? title;
  String? content;
  String? time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['content'] = content;
    map['time'] = time;
    return map;
  }

}