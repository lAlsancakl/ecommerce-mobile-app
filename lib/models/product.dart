/// Product model representing a product in the e-commerce application.
/// 
/// This model includes all necessary fields for displaying and managing products
/// throughout the application, with built-in JSON serialization.
class Product {
  /// Unique identifier for the product
  final int id;

  /// Product title/name
  final String title;

  /// Detailed product description
  final String description;

  /// Product price in decimal format
  final double price;

  /// Product image URL or path
  final String image;

  /// Product rating (out of 5)
  final double rating;

  /// Product category
  final String category;

  /// Product stock count
  final int stock;

  /// Product specifications (key-value pairs)
  final Map<String, String> specifications;

  /// Creates a new Product instance
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    required this.category,
    required this.stock,
    required this.specifications,
  });

  /// Creates a Product instance from a JSON map
  /// 
  /// This factory constructor handles JSON deserialization from API responses
  /// or mock data, with null safety checks and default values
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? 'Unknown Product',
      description: json['description'] as String? ?? 'No description available',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] as String? ?? 'https://via.placeholder.com/300',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      category: json['category'] as String? ?? 'General',
      stock: json['stock'] as int? ?? 0,
      specifications: Map<String, String>.from(
        (json['specifications'] as Map<dynamic, dynamic>? ?? {})
            .map((key, value) => MapEntry(key.toString(), value.toString())),
      ),
    );
  }

  /// Converts the Product instance to a JSON map
  /// 
  /// This method handles JSON serialization for saving or sending product data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'rating': rating,
      'category': category,
      'stock': stock,
      'specifications': specifications,
    };
  }

  /// Creates a copy of the Product with some fields overridden
  /// 
  /// Useful for creating modified versions of products without mutating
  /// the original instance (immutability pattern)
  Product copyWith({
    int? id,
    String? title,
    String? description,
    double? price,
    String? image,
    double? rating,
    String? category,
    int? stock,
    Map<String, String>? specifications,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      category: category ?? this.category,
      stock: stock ?? this.stock,
      specifications: specifications ?? this.specifications,
    );
  }

  @override
  String toString() => 'Product(id: $id, title: $title, price: $price)';
}
