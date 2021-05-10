import 'package:ecommerce_arcore/model_type.dart';
import 'package:ecommerce_arcore/product.dart';

List<Product> getTempProduct() {
  List<Product> temp = [];
  temp.add(Product(
      'Centiar Dining Chair',
      "Mid-century design, updated for today's lifestyle. Centiar upholstered dining chairs come to the table with more than just good looks. They're covered with high performance Nuvella® fabric, which offers unbeatable stain resistance.",
      "https://drive.google.com/uc?export=download&id=12wj-N2Q5relKn7VDYgUOUGXit4NVJvtf",
      "https://poly.googleusercontent.com/downloads/c/fp/1572515318989256/7Q_Ab2HLll1/3haaSnzO63h/model.gltf",
      ModelType.GLTF,
      99.9));

  temp.add(Product(
      'Berringer Dining Bench',
      "Berringer serves up easy elegance, family style. The rich, rustic finish and simple profile are always in vogue, whether your aesthetic is vintage, country or traditional. Dining room bench comfortably seats two.",
      "https://drive.google.com/uc?export=download&id=1nzRMCgF-0yGPQkxDeOs23_NpLQDYdSnS",
      "https://poly.googleusercontent.com/downloads/c/fp/1572515318989256/7Q_Ab2HLll1/3haaSnzO63h/model.gltf",
      ModelType.GLTF,
      124));

  temp.add(Product(
      'Berringer Dining Drop Leaf Extendable Table',
      "The Berringer dining room table incorporates decidedly rustic flair. Two drop leaves provide just enough table space to accommodate the drop-in guest. Simple and clean lined, with stylish stilted legs, it’s a look that easily fits, whether your aesthetic is vintage, country or traditional.",
      "https://drive.google.com/uc?export=download&id=1EFXrGXdpU2cV83dusYzphnp9LA0F1Qgm",
      "https://poly.googleusercontent.com/downloads/c/fp/1572515318989256/7Q_Ab2HLll1/3haaSnzO63h/model.gltf",
      ModelType.GLTF,
      200));
  temp.add(Product(
      'Hollyann Sofa',
      "Cool takes a new shape in your living room with the Hollyann sofa. Rounding out your stylish, urban space, this piece sports a velvety soft upholstery and sleek, tapered legs. Curl up with comfort, and really turn around your home decor.",
      "https://drive.google.com/uc?export=download&id=1Gb2RgeThSt6eXyJqWYzmr7wP75NKbad0",
      "https://poly.googleusercontent.com/downloads/c/fp/1572515318989256/7Q_Ab2HLll1/3haaSnzO63h/model.gltf",
      ModelType.GLTF,
      177.5));

  return temp;
}
