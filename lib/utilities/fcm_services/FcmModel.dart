class FcmModel {
  FcmModel({
    String? loginId,
    String? fcmToken,
  }) {
    _loginId = loginId;
    _fcmToken = fcmToken;
  }

  FcmModel.fromJson(dynamic json) {
    _loginId = json['loginId'];
    _fcmToken = json['fcm_token'];
  }

  String? _loginId;
  String? _fcmToken;

  String? get loginId => _loginId;

  String? get fcmToken => _fcmToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['loginId'] = _loginId;
    map['fcm_token'] = _fcmToken;
    return map;
  }
}
