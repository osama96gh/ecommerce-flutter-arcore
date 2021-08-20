import 'package:ecommerce_arcore/models/model_type.dart';
import 'package:ecommerce_arcore/models/product.dart';

List<Product> getTempProduct() {
  List<Product> temp = [];
  temp.add(Product(
      name: 'Centiar Dining Chair',
      description:
          "Mid-century design, updated for today's lifestyle. Centiar upholstered dining chairs come to the table with more than just good looks. They're covered with high performance Nuvella® fabric, which offers unbeatable stain resistance.",
      imageUrl: "https://www.smart-furniture-store.cf/images/chair.jpg",
      modelUrl: "file:///android_asset/chair.glb",
      modelType: ModelType.GLB,
      price: 99.9));

  temp.add(Product(
      name: 'Berringer Dining Bench',
      description:
          "Berringer serves up easy elegance, family style. The rich, rustic finish and simple profile are always in vogue, whether your aesthetic is vintage, country or traditional. Dining room bench comfortably seats two.",
      imageUrl: "https://www.smart-furniture-store.cf/images/sofa.jpg",
      modelUrl: "file:///android_asset/sofa.glb",
      modelType: ModelType.GLB,
      price: 124));

  temp.add(Product(
      name: 'Berringer Dining Drop Leaf Extendable Table',
      description:
          "The Berringer dining room table incorporates decidedly rustic flair. Two drop leaves provide just enough table space to accommodate the drop-in guest. Simple and clean lined, with stylish stilted legs, it’s a look that easily fits, whether your aesthetic is vintage, country or traditional.",
      imageUrl: "https://www.smart-furniture-store.cf/images/sofa2.jpg",
      modelUrl: "file:///android_asset/sofa2.glb",
      modelType: ModelType.GLB,
      price: 200));
  temp.add(Product(
      name: 'Hollyann Sofa',
      description:
          "Cool takes a new shape in your living room with the Hollyann sofa. Rounding out your stylish, urban space, this piece sports a velvety soft upholstery and sleek, tapered legs. Curl up with comfort, and really turn around your home decor.",
      imageUrl: "https://www.smart-furniture-store.cf/images/table-1.jpg",
      modelUrl: "file:///android_asset/table.glb",
      modelType: ModelType.GLB,
      price: 177.5));

  temp.add(Product(
      name: 'China Cabinet',
      description:
          "Cool takes a new shape in your living room with the Hollyann sofa. Rounding out your stylish, urban space, this piece sports a velvety soft upholstery and sleek, tapered legs. Curl up with comfort, and really turn around your home decor.",
      imageUrl: "https://www.smart-furniture-store.cf/images/china-cabinet.png",
      modelUrl: "file:///android_asset/china_cabinet.glb",
      modelType: ModelType.GLB,
      price: 177.5));

  return temp;
}
