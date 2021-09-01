import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:ecommerce_arcore/models/config_file.dart';
import 'package:ecommerce_arcore/models/enums.dart';
import 'package:ecommerce_arcore/models/product.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApplicationState with ChangeNotifier {
  List<Product> products = [];
  HashMap<String, List<Product>> categories = HashMap<String, List<Product>>();

  List<Product> userProducts = [];
  bool isLoadProducts = true;
  bool isErrorLoadProduct = false;

  bool isLoadUserProducts = true;
  bool isErrorLoadUserProduct = false;

  ApplicationState() {
    init();
  }

  Future refresh() {
    userProducts.clear();
    for (ProductCategory c in ProductCategory.values) {
      categories[EnumToString.convertToString(c)].clear();
    }
    notifyListeners();
    init();
  }

  Future<void> init() async {
    fetchAllProducts();
    fetchUserProducts();
    for (ProductCategory c in ProductCategory.values) {
      categories.putIfAbsent(EnumToString.convertToString(c), () => []);
    }
    for (ProductCategory c in ProductCategory.values) {
      List<Product> pl = categories[EnumToString.convertToString(c)];

      pl.addAll(await fetchCategoryProducts(c));
      notifyListeners();
    }
  }

  Future<void> fetchAllProducts() async {
    isLoadProducts = true;
    isErrorLoadProduct = false;

    isLoadUserProducts = true;
    isErrorLoadUserProduct = false;
    final response =
        await http.post(Uri.parse(ConfigData.baseUrl + 'get_products'));

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

  Future<void> fetchUserProducts() async {
    isLoadUserProducts = true;
    isErrorLoadUserProduct = false;
    final response =
        await http.post(Uri.parse(ConfigData.baseUrl + 'get_user_products'));

    print('gi');
    if (response.statusCode == 200) {
      print(response.body);
      Iterable l = json.decode(response.body);
      userProducts =
          List<Product>.from(l.map((model) => Product.fromJson(model)));
    } else {
      isErrorLoadUserProduct = true;
      userProducts.clear();
    }
    isLoadUserProducts = false;
    notifyListeners();
  }

  Future<List<Product>> fetchCategoryProducts(ProductCategory category) async {
    List<Product> products = [];
    isLoadProducts = true;
    isErrorLoadProduct = false;

    isLoadUserProducts = true;
    isErrorLoadUserProduct = false;
    final response = await http
        .post(Uri.parse(ConfigData.baseUrl + 'get_products'), body: {
      "category": EnumToString.convertToString(category).toLowerCase()
    });
    if (response.statusCode == 200) {
      print(response.body);
      Iterable l = json.decode(response.body);
      products = List<Product>.from(l.map((model) => Product.fromJson(model)));
    } else {
      isErrorLoadProduct = true;
      products.clear();
    }
    isLoadProducts = false;
    return products;
  }
}
