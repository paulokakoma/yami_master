class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final bool isAvailable;
  final int? quantity;
  final String sellerPhone;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.sellerPhone,
    this.isAvailable = true,
    this.quantity,
  });

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
    String? sellerPhone,
    bool? isAvailable,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      sellerPhone: sellerPhone ?? this.sellerPhone,
      isAvailable: isAvailable ?? this.isAvailable,
      quantity: quantity ?? this.quantity,
    );
  }
}
