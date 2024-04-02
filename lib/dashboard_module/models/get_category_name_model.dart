import 'dart:convert';
GetCategoryNameModel getCategoryNameModelFromJson(String str) => GetCategoryNameModel.fromJson(json.decode(str));
String getCategoryNameModelToJson(GetCategoryNameModel data) => json.encode(data.toJson());
class GetCategoryNameModel {
  GetCategoryNameModel({
      this.status, 
      this.response, 
      this.results,});

  GetCategoryNameModel.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'];
    if (json['results'] != null) {
      results = [];
      List<dynamic>.from(
          json['results'].map((x) => List<Results>.from(x.map((x) => Results.fromJson(x))))).forEach((element) => results!.add(element)); //List<List<Results>>.from(json['results'].result!.map((x) => List<dynamic>.from(x.map((v) => v.toJson()))))
    }
  }
  num? status;
  String? response;
  List<List<Results>>? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['response'] = response;
    if (results != null) {
      map['results'] = results?.map((v) => v).toList();
    }
    return map;
  }

}

Results resultsFromJson(String str) => Results.fromJson(json.decode(str));
String resultsToJson(Results data) => json.encode(data.toJson());
class Results {
  Results({
      this.subcategory, 
      this.imageUrl, 
      this.categoryCount,});

  Results.fromJson(dynamic json) {
    subcategory = json['subcategory'];
    imageUrl = json['image_url'];
    categoryCount = json['category_count'];
  }
  String? subcategory;
  String? imageUrl;
  num? categoryCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subcategory'] = subcategory;
    map['image_url'] = imageUrl;
    map['category_count'] = categoryCount;
    return map;
  }

}