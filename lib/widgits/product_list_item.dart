import 'package:ecommerce_arcore/models/product.dart';
import 'package:ecommerce_arcore/pages/product_detailes/product_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductVerticleListItem extends StatelessWidget {
  const ProductVerticleListItem({
    Key key,
    @required this.p,
  }) : super(key: key);

  final Product p;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Stack(children: [
          InkWell(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 2,
                    child: Hero(
                      tag: p.imageUrl,
                      child: Image.network(
                        p.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // child: Image.asset(
                    //   'Images/a.jpg',
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                p.name,
                                maxLines: 13,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${p.price}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(" K "),
                                    Text(
                                      'S.P.',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 8,
                    color: Colors.amber,
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ProductPage(p);
                },
              ));
            },
          )
        ]),
      ),
    );
  }
}

class ProductHorizentalListItem extends StatelessWidget {
  const ProductHorizentalListItem({
    Key key,
    @required this.p,
  }) : super(key: key);

  final Product p;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.blue.shade50,
              Colors.blue.shade200,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          )),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: EdgeInsets.all(12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Hero(
                        tag: p.imageUrl,
                        child: Image.network(
                          p.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            p.name,
                            maxLines: 13,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${p.price}',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Text(" K "),
                                Text(
                                  'S.P.',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ProductPage(p);
                },
              ));
            },
          ),
        ),
      ),
    );
  }
}
