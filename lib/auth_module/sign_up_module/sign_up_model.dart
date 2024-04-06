class SignUpModel {
  SignUpModel({
      this.status, 
      this.response, 
      this.token,});

  SignUpModel.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'];
    token = json['token'];
  }
  num? status;
  String? response;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['response'] = response;
    map['token'] = token;
    return map;
  }

}