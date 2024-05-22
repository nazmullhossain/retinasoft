class ProfileModel {
  int? status;
  String? msg;
  String? description;
  ResponseUser? responseUser;

  ProfileModel({this.status, this.msg, this.description, this.responseUser});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    description = json['description'];
    responseUser = json['response_user'] != null
        ? new ResponseUser.fromJson(json['response_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['description'] = this.description;
    if (this.responseUser != null) {
      data['response_user'] = this.responseUser!.toJson();
    }
    return data;
  }
}

class ResponseUser {
  int? id;
  String? name;
  String? email;
  String? phone;
  dynamic? image;
  dynamic? imageFullPath;
  String? businessName;
  String? businessType;
  int? businessTypeId;
  String? branch;
  int? companyId;
  int? branchId;

  ResponseUser(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.image,
        this.imageFullPath,
        this.businessName,
        this.businessType,
        this.businessTypeId,
        this.branch,
        this.companyId,
        this.branchId});

  ResponseUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    imageFullPath = json['image_full_path'];
    businessName = json['business_name'];
    businessType = json['business_type'];
    businessTypeId = json['business_type_id'];
    branch = json['branch'];
    companyId = json['company_id'];
    branchId = json['branch_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['image_full_path'] = this.imageFullPath;
    data['business_name'] = this.businessName;
    data['business_type'] = this.businessType;
    data['business_type_id'] = this.businessTypeId;
    data['branch'] = this.branch;
    data['company_id'] = this.companyId;
    data['branch_id'] = this.branchId;
    return data;
  }
}
