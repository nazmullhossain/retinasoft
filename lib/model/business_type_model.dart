import 'dart:convert';

BusinessTypeModel customerModelFromJson(String str) =>
    BusinessTypeModel.fromJson(json.decode(str));
class BusinessTypeModel {
  int? status;
  String? msg;
  String? description;
  List<BusinessTypes>? businessTypes;

  BusinessTypeModel(
      {this.status, this.msg, this.description, this.businessTypes});

  BusinessTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    description = json['description'];
    if (json['business_types'] != null) {
      businessTypes = <BusinessTypes>[];
      json['business_types'].forEach((v) {
        businessTypes!.add(new BusinessTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['description'] = this.description;
    if (this.businessTypes != null) {
      data['business_types'] =
          this.businessTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BusinessTypes {
  int? id;
  String? name;
  String? slug;

  BusinessTypes({this.id, this.name, this.slug});

  BusinessTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}
