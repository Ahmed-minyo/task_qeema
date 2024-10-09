class ProductModel {
  final int? id;
  final String title;
  final double price;
  final String description;
  final String image;
  final String category;

  ProductModel({
    this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
  });

  // Converts a ProductModel instance into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'image': image,
      'category': category,
    };
  }

  // Creates a ProductModel instance from a Map
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      description: map['description'],
      image: map['image'],
      category: map['category'],
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      image: json['image'],
      category: json['category'],
    );
  }
}
