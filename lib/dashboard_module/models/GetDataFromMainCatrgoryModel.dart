import 'dart:convert';
GetDataFromMainCategoryModel getDataFromMainCategoryModelFromJson(String str) => GetDataFromMainCategoryModel.fromJson(json.decode(str));
String getDataFromMainCategoryModelToJson(GetDataFromMainCategoryModel data) => json.encode(data.toJson());
class GetDataFromMainCategoryModel {
  GetDataFromMainCategoryModel({
      this.status, 
      this.response, 
      this.result,});

  GetDataFromMainCategoryModel.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'];
    if (json['result'] != null) { // corrected typo here from 'results' to 'result'
      result = [];
      List<dynamic>.from(
          json['result'].map((x) => List<Result>.from(x.map((x) => Result.fromJson(x))))).forEach((element) => result!.add(element));
    }
  }

  num? status;
  String? response;
  List<List<Result>>? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;

    map['response'] = response;
    if (result != null) {
      map['results'] = result?.map((v) => v).toList();
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
  num? price;
  num? mrp;
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