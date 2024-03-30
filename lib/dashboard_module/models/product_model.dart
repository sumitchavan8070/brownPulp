import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.status,
    this.response,
    this.result,
  });

  num? status;
  String? response;
  List<List<Result>>? result;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    status: json['status'],
    response: json['response'],
    result: List<List<Result>>.from(
        json['result'].map((x) => List<Result>.from(x.map((v) => Result.fromJson(v))))),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'response': response,
    'result': List<dynamic>.from(
        result!.map((x) => List<dynamic>.from(x.map((v) => v.toJson())))),
  };
}

class Result {
  Result({
    this.id,
    this.subcategory,
    this.name,
    this.brand,
    this.price,
    this.mrp,
    this.discount,
    this.image,
  });

  num? id;
  String? subcategory;
  String? name;
  String? brand;
  String? price;
  String? mrp;
  String? discount;
  String? image;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json['id'],
    subcategory: json['subcategory'],
    name: json['name'],
    brand: json['brand'],
    price: json['price'],
    mrp: json['mrp'],
    discount: json['discount'],
    image: json['image'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'subcategory': subcategory,
    'name': name,
    'brand': brand,
    'price': price,
    'mrp': mrp,
    'discount': discount,
    'image': image,
  };
}
