import 'package:ecommerce_arcore/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  ProductPage(this.product);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  static const platform = const MethodChannel('com.og.ecommerce_arcore/ar');

  Future<void> _startAcActivity() async {
    var res;
    try {
      final int result = await platform.invokeMethod('startArActivity', {
        "title": widget.product.name,
        "url": widget.product.modelUrl,
        "type": widget.product.modelType.index
      });
      res = '$result .';
    } on PlatformException catch (e) {
      res = "Failed to get result: '${e.message}'.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  stretch: true,
                  pinned: true,
                  snap: false,
                  floating: false,
                  expandedHeight: MediaQuery.of(context).size.width,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Hero(
                      tag: widget.product.name,
                      child: Text(
                        widget.product.name.length <= 25
                            ? widget.product.name
                            : '${widget.product.name.substring(0, 23)}...',
                        style: TextStyle(color: Colors.blue.shade600, shadows: [
                          Shadow(
                            color: Colors.white,
                            blurRadius: 8,
                          ),
                        ]),
                      ),
                    ),
                    background: Hero(
                      tag: widget.product.imageUrl,
                      child: Image.network(
                        widget.product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 16, left: 16),
                        child: Text(
                          'Description:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(16.0),
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          widget.product.description,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                            height: 1.5,
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade200,
                              Colors.blue.shade100,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                      ),
                      Divider(),
                      Container(
                        margin: EdgeInsets.only(top: 16, left: 16),
                        child: Text(
                          'Price:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(16.0),
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '${widget.product.price} K S.P.',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade200,
                              Colors.blue.shade100,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: OutlinedButton.icon(
                        onPressed: _startAcActivity,
                        icon: Icon(Icons.remove_red_eye_rounded),
                        label: Text("Preview"),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.add_shopping_cart_rounded),
                          label: Text("Add to cart")),
                    ),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
          )
        ],
      ),
    );
  }
}
