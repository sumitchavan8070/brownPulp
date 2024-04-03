class MyOrdersModel {
  MyOrdersModel({
      this.status, 
      this.response, 
      this.orders, 
      this.products,});

  MyOrdersModel.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'];
    orders = json['orders'] != null ? json['orders'].cast<num>() : [];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
  }
  num? status;
  String? response;
  List<num>? orders;
  List<Products>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['response'] = response;
    map['orders'] = orders;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Products {
  Products({
      this.id, 
      this.subcategory, 
      this.name, 
      this.brand, 
      this.price, 
      this.mrp, 
      this.discount, 
      this.image,});

  Products.fromJson(dynamic json) {
    id = json['id'];
    subcategory = json['subcategory'];
    name = json['name'];
    brand = json['brand'];
    price = json['price'];
    mrp = json['mrp'];
    discount = json['discount'];
    image = json['image'];
  }
  num? id;
  String? subcategory;
  String? name;
  String? brand;
  String? price;
  String? mrp;
  String? discount;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['subcategory'] = subcategory;
    map['name'] = name;
    map['brand'] = brand;
    map['price'] = price;
    map['mrp'] = mrp;
    map['discount'] = discount;
    map['image'] = image;
    return map;
  }

}