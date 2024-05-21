class CustomerModel {
  int? status;
  String? msg;
  String? description;
  Customers? customers;

  CustomerModel({this.status, this.msg, this.description, this.customers});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    description = json['description'];
    customers = json['customers'] != null
        ? new Customers.fromJson(json['customers'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['description'] = this.description;
    if (this.customers != null) {
      data['customers'] = this.customers!.toJson();
    }
    return data;
  }
}

class Customers {
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
  List<Customers2>? customers2;


  Customers(
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
        this.customers2});

  Customers.fromJson(Map<String, dynamic> json) {
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
    if (json['customers'] != null) {
      customers2 = <Customers2>[];
      json['customers'].forEach((v) {
        customers2!.add(new Customers2.fromJson(v));
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
    if (this.customers2 != null) {
      data['customers'] = this.customers2!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customers2 {
  int? id;
  String? name;
  String? phone;
  String? balance;

  Customers2({this.id, this.name, this.phone, this.balance});

  Customers2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['balance'] = this.balance;
    return data;
  }
}
