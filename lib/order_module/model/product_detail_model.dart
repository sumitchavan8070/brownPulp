class ProductDetailModel {
  ProductDetailModel({
      this.status, 
      this.response, 
      this.result,});

  ProductDetailModel.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  num? status;
  String? response;
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['response'] = response;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }

}

class Result {
  Result({
      this.id, 
      this.brand, 
      this.subcategory, 
      this.name, 
      this.price, 
      this.mrp, 
      this.discount, 
      this.image,});

  Result.fromJson(dynamic json) {
    id = json['id'];
    brand = json['brand'];
    subcategory = json['subcategory'];
    name = json['name'];
    price = json['price'];
    mrp = json['mrp'];
    discount = json['discount'];
    image = json['image'];
  }
  num? id;
  String? brand;
  String? subcategory;
  String? name;
  String? price;
  String? mrp;
  String? discount;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['brand'] = brand;
    map['subcategory'] = subcategory;
    map['name'] = name;
    map['price'] = price;
    map['mrp'] = mrp;
    map['discount'] = discount;
    map['image'] = image;
    return map;
  }

}