class AddToCartModel {
  AddToCartModel({
      this.status, 
      this.response, 
      this.updatedOrders,});

  AddToCartModel.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'];
    updatedOrders = json['updatedOrders'] != null ? json['updatedOrders'].cast<num>() : [];
  }
  num? status;
  String? response;
  List<num>? updatedOrders;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['response'] = response;
    map['updatedOrders'] = updatedOrders;
    return map;
  }

}