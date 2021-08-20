import 'package:ecommerce_arcore/app_state.dart';
import 'package:ecommerce_arcore/models/product.dart';
import 'package:ecommerce_arcore/widgits/product_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<ApplicationState>(builder: (context, appState, child) {
        if (appState.products.length > 0) {
          return ListView.builder(
            itemBuilder: (context, index) {
              Product p = appState.products[index];
              return ProductListItem(p: p);
            },
            itemCount: appState.products.length,
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
