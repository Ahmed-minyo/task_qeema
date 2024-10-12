class ProductModel {
  final int? id;
  final String title;
  final double price;
  final String description;

  ProductModel({
    this.id,
    required this.title,
    required this.price,
    required this.description,
  });

  // Converts a ProductModel instance into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
    };
  }

  // Creates a ProductModel instance from a Map
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      description: map['description'],
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
    );
  }
}
