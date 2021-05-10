import 'model_type.dart';

class Product {
  String title;
  String description;
  String imageUrl;
  String modelUrl;
  double price;
  ModelType modelType;

  Product(this.title, this.description, this.imageUrl, this.modelUrl,
      this.modelType, this.price);
}
