import 'package:ecommerce_arcore/app_state.dart';
import 'package:ecommerce_arcore/models/enums.dart';
import 'package:ecommerce_arcore/models/product.dart';
import 'package:ecommerce_arcore/widgits/product_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  ProductListPage({Key key, this.title, @required this.category})
      : super(key: key);

  final String title;
  final ProductCategory category;

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Consumer<ApplicationState>(builder: (context, appState, child) {
        if (appState.userProducts.length > 0) {
          return ListView.builder(
            itemBuilder: (context, index) {
              Product p = appState.userProducts[index];
              return ProductVerticleListItem(p: p);
            },
            itemCount: appState.userProducts.length,
          );
        } else {
          if (appState.isLoadProducts) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (appState.isErrorLoadProduct) {
              return Center(
                child: Text(
                  "Error Occurred during feaching data",
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else {
              return Center(
                child: Text('No Things To Show'),
              );
            }
          }
        }
      }),
    );
  }
}
