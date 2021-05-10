import 'package:ecommerce_arcore/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  ProductPage(this.product);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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
                  stretch: true,
                  pinned: true,
                  snap: false,
                  floating: false,
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      widget.product.title.length <= 25
                          ? widget.product.title
                          : '${widget.product.title.substring(0, 23)}...',
                      style: TextStyle(shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 8,
                        ),
                      ]),
                    ),
                    background: Image.network(
                      widget.product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 16,left: 16),
                      child: Text( 'Description:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),

                    ),
                    Container(
                      margin: EdgeInsets.all(16.0),
                      padding: EdgeInsets.all(8),
                      child: Text(widget.product.description,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.amber,width: 2)),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 16,left: 16),
                      child: Text( 'Price:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),

                    ),
                    Container(
                      margin: EdgeInsets.all(16.0),
                      padding: EdgeInsets.all(8),
                      child: Text('${widget.product.price} K S.P.',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.amber,width: 2)),
                    ),
                  ],
                )),
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
                        onPressed: () {},
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
