import 'dart:async';
import 'dart:convert';

import 'package:ecommerce_arcore/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApplicationState with ChangeNotifier {
  List<Product> products = [];
  bool isLoadProducts = true;
  bool isErrorLoadProduct = false;

  ApplicationState() {
    init();
  }

  Future<void> init() async {
    fetchProducts();
  }

  Future<Product> fetchProducts() async {
    isLoadProducts = true;
    isErrorLoadProduct = false;
    final response =
        await http.post(Uri.parse('http://192.168.1.5:9000/get_products'));

    print('gi');
    if (response.statusCode == 200) {
      print(response.body);
      Iterable l = json.decode(response.body);
      products = List<Product>.from(l.map((model) => Product.fromJson(model)));
    } else {
      isErrorLoadProduct = true;
      products.clear();
    }
    isLoadProducts = false;
    notifyListeners();
  }
}
