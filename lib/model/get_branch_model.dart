class GetBrachModel {
  int? status;
  String? msg;
  String? description;
  Branches? branches;

  GetBrachModel({this.status, this.msg, this.description, this.branches});

  GetBrachModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    description = json['description'];
    branches = json['branches'] != null
        ? new Branches.fromJson(json['branches'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['description'] = this.description;
    if (this.branches != null) {
      data['branches'] = this.branches!.toJson();
    }
    return data;
  }
}

class Branches {
  int? perPage;
  int? from;
  int? to;
  int? total;
  int? currentPage;
  int? lastPage;
  dynamic? prevPageUrl;
  String? firstPageUrl;
  dynamic? nextPageUrl;
  String? lastPageUrl;
  List<Branches2>? branches2;

  Branches(
      {this.perPage,
        this.from,
        this.to,
        this.total,
        this.currentPage,
        this.lastPage,
        this.prevPageUrl,
        this.firstPageUrl,
        this.nextPageUrl,
        this.lastPageUrl,
        this.branches2});

  Branches.fromJson(Map<String, dynamic> json) {
    perPage = json['per_page'];
    from = json['from'];
    to = json['to'];
    total = json['total'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    prevPageUrl = json['prev_page_url'];
    firstPageUrl = json['first_page_url'];
    nextPageUrl = json['next_page_url'];
    lastPageUrl = json['last_page_url'];
    if (json['branches'] != null) {
      branches2 = <Branches2>[];
      json['branches'].forEach((v) {
        branches2!.add(new Branches2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['per_page'] = this.perPage;
    data['from'] = this.from;
    data['to'] = this.to;
    data['total'] = this.total;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['first_page_url'] = this.firstPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['last_page_url'] = this.lastPageUrl;
    if (this.branches2 != null) {
      data['branches'] = this.branches2!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Branches2 {
  int? id;
  String? name;

  Branches2({this.id, this.name});

  Branches2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
