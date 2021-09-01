import 'dart:io';

import 'package:async/async.dart';
import 'package:ecommerce_arcore/models/config_file.dart';
import 'package:ecommerce_arcore/pages/similar_products/similar_products.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class SearchSimilarPage extends StatefulWidget {
  const SearchSimilarPage({Key key}) : super(key: key);

  @override
  _SearchSimilarPageState createState() => _SearchSimilarPageState();
}

class _SearchSimilarPageState extends State<SearchSimilarPage> {
  final ImagePicker _picker = ImagePicker();
  XFile image;
  bool isSending = false;

  void _loadImage({bool isFromCamera}) async {
    XFile i = await _picker.pickImage(
        source: isFromCamera ? ImageSource.camera : ImageSource.gallery);
    setState(() {
      image = i;
    });
  }

  void _upload(context, XFile imageFile, String uploadURL) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(uploadURL);

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    request.fields.addAll({"file_name": basename(imageFile.path)});

    setState(() {
      isSending = true;
    });
    var response = await request.send();
    print(response.statusCode);

    final respStr = await response.stream.bytesToString();
    setState(() {
      isSending = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          // return AddDrugScreen(
          //   serialNumber: barcodeScanRes,
          // );
          // return QRViewExample();

          return SimilarProductsPage(respStr);
        },
      ),
    );
    // response.stream.transform(utf8.decoder).listen((value) {
    //   print("Doooooneee!");
    //   print(value);

    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Search For Similar Furniture"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
                margin: EdgeInsets.all(8),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Card(
                      child: Builder(
                        builder: (context) {
                          if (image == null) {
                            return Center(
                                child: Text("Upload or Take a Photo"));
                          } else {
                            return Image.file(File(image.path));
                          }
                        },
                      ),
                    ),
                  ),
                )),
          ),
          Container(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          _loadImage(isFromCamera: false);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.upload_rounded,
                              size: 80,
                            ),
                            Text('Upload image')
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          _loadImage(isFromCamera: true);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.camera_alt_rounded,
                              size: 80,
                            ),
                            Text('Take image')
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Builder(
            builder: (context) {
              if (!isSending) {
                return Container(
                  margin: EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(100, 50)),
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 22))),
                    onPressed: image == null
                        ? null
                        : () {
                            _upload(context, image,
                                ConfigData.baseUrl + 'search_similar');
                          },
                    child: Text("Search"),
                  ),
                );
              } else {
                return Container(
                  margin: EdgeInsets.all(8),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
          SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}
