class DashBoardModel {
  DashBoardModel({
      this.status, 
      this.response, 
      this.subcategories,});

  DashBoardModel.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'];
    if (json['subcategories'] != null) {
      subcategories = [];
      json['subcategories'].forEach((v) {
        subcategories?.add(Subcategories.fromJson(v));
      });
    }
  }
  num? status;
  String? response;
  List<Subcategories>? subcategories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['response'] = response;
    if (subcategories != null) {
      map['subcategories'] = subcategories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Subcategories {
  Subcategories({
      this.subcategory,});

  Subcategories.fromJson(dynamic json) {
    subcategory = json['subcategory'];
  }
  String? subcategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subcategory'] = subcategory;
    return map;
  }

}