import 'package:ecommerce_arcore/app_state.dart';
import 'package:ecommerce_arcore/models/config_file.dart';
import 'package:ecommerce_arcore/models/enums.dart';
import 'package:ecommerce_arcore/pages/search_similar/search_similar_page.dart';
import 'package:ecommerce_arcore/widgits/product_list_item.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, appState, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Furniture Store'),
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: IconButton(
                    onPressed: () {
                      appState.refresh();
                    },
                    icon: Icon(Icons.refresh),
                  )),
              Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: IconButton(
                    onPressed: () {
                      var myController = TextEditingController();
                      myController.text = ConfigData.baseUrl;
                      showDialog(
                        builder: (context) => new AlertDialog(
                          title: Text("Set Server Address"),
                          content: TextField(
                            controller: myController,
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: Text("Done"),
                              onPressed: () {
                                String ip = myController.text;
                                ConfigData.baseUrl = ip;
                                myController.dispose();
                                appState.refresh();
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ),
                        context: context,
                      );
                    },
                    icon: Icon(Icons.settings),
                  )),
            ],
          ),
          body: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(
                        8.0,
                      ),
                      child: Text(
                        "Like Your Style",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward_rounded),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ProductHorizentalListItem(
                        p: appState.userProducts[index]);
                  },
                  itemCount: appState.userProducts.length,
                ),
              ),
              Column(
                children: [
                  for (ProductCategory c in ProductCategory.values)
                    Column(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(
                                  8.0,
                                ),
                                child: Text(
                                  EnumToString.convertToString(c),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward_rounded),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.55,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return ProductHorizentalListItem(
                                  p: appState.categories[
                                      EnumToString.convertToString(c)][index]);
                            },
                            itemCount: appState
                                .categories[EnumToString.convertToString(
                                    ProductCategory.BEDS)]
                                .length,
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Container(
                margin: EdgeInsets.all(12),
                child: Image(
                  color: Colors.white,
                  image: AssetImage('images/search_by_image.png'),
                )),
            onPressed: () async {
              // String barcode = (await BarcodeScanner.scan()) as String;
              // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              //     "#ff6666", "Cancel", false, ScanMode.DEFAULT);
              //
              // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              //     "#ff6666", "Cancel", true, ScanMode.DEFAULT);

              // Provider.of<ApplicationState>(context, listen: false).addDummyDrug();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    // return AddDrugScreen(
                    //   serialNumber: barcodeScanRes,
                    // );
                    // return QRViewExample();

                    return SearchSimilarPage();
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
