class RemoveFromMyCartModel {
  RemoveFromMyCartModel({
      this.status, 
      this.response, 
      this.orderId,});

  RemoveFromMyCartModel.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'];
    orderId = json['orderId'];
  }
  num? status;
  String? response;
  String? orderId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['response'] = response;
    map['orderId'] = orderId;
    return map;
  }

}