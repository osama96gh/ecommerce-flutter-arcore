import 'dart:convert';

import 'package:ecommerce_arcore/models/product.dart';
import 'package:ecommerce_arcore/widgits/product_list_item.dart';
import 'package:flutter/material.dart';

class SimilarProductsPage extends StatefulWidget {
  final String data;

  const SimilarProductsPage(this.data, {Key key}) : super(key: key);

  @override
  _SimilarProductsPageState createState() => _SimilarProductsPageState();
}

class _SimilarProductsPageState extends State<SimilarProductsPage> {
  List<Product> products = [];

  _parseProducts() async {
    print('------------------------------');
    print(widget.data);
    print('------------------------------');

    Iterable l = json.decode(widget.data);
    products = List<Product>.from(l.map((model) => Product.fromJson(model)));
  }

  @override
  void initState() {
    _parseProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Similar Products"),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          if (products.length != 0) {
            return ListView.builder(
              itemBuilder: (context, index) {
                Product p = products[index];
                return ProductVerticleListItem(p: p);
              },
              itemCount: products.length,
            );
          } else {
            return Center(
              child: Text("No Similar To Show!"),
            );
          }
        },
      ),
    );
  }
}
