import 'dart:async';
import 'package:flutter/cupertino.dart';

import '../model/get_branch_model.dart';
import 'api_helper.dart';


class CustomerProvider {
  final ApiHelper _apiService = ApiHelper();
  final StreamController<List<Branches2>> _controller = StreamController<List<Branches2>>();

  Stream<List<Branches2>> get customersStream => _controller.stream;

  CustomerProvider() {
    _fetchCustomers();
  }

  void _fetchCustomers() async {
    try {
      List<Branches2> customers = await _apiService.getBranch();
      _controller.sink.add(customers);
    } catch (e) {
      _controller.sink.addError(e);
    }
  }

  void dispose() {
    _controller.close();
  }
}
