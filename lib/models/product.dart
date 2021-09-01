import 'enums.dart';

class Product {
  String name;
  String description;
  String imageUrl;
  String modelUrl;
  double price;
  ModelType modelType;

  Product(
      {this.name,
      this.description,
      this.imageUrl,
      this.modelUrl,
      this.modelType,
      this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        name: json['name'],
        description: json['description'],
        imageUrl: json['image_url'],
        modelUrl: json['model_url'],
        modelType: ModelType.values.firstWhere(
            (e) => e.toString() == 'ModelType.' + json['model_type']),
        price: json['price']);
  }
}
