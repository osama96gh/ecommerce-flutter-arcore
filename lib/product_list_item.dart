import 'package:ecommerce_arcore/product.dart';
import 'package:ecommerce_arcore/product_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                    child: Image.network(
                      p.imageUrl,
                      fit: BoxFit.fitHeight,
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
                                p.title,
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
