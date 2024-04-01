import 'dart:convert';
DashBoardModel dashBoardModelFromJson(String str) => DashBoardModel.fromJson(json.decode(str));
String dashBoardModelToJson(DashBoardModel data) => json.encode(data.toJson());
class DashBoardModel {
  DashBoardModel({
      this.status, 
      this.response, 
      this.homeTitle, 
      this.categories, 
      this.result,});

  DashBoardModel.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'];
    homeTitle = json['homeTitle'];
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
  }
  num? status;
  String? response;
  String? homeTitle;
  List<Categories>? categories;
  List<Result>? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['response'] = response;
    map['homeTitle'] = homeTitle;
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      this.id, 
      this.subcategory, 
      this.name, 
      this.brand, 
      this.price, 
      this.mrp, 
      this.discount, 
      this.image,});

  Result.fromJson(dynamic json) {
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

Categories categoriesFromJson(String str) => Categories.fromJson(json.decode(str));
String categoriesToJson(Categories data) => json.encode(data.toJson());
class Categories {
  Categories({
      this.name, 
      this.image, 
      this.route,});

  Categories.fromJson(dynamic json) {
    name = json['name'];
    image = json['image'];
    route = json['route'];
  }
  String? name;
  String? image;
  String? route;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['image'] = image;
    map['route'] = route;
    return map;
  }

}