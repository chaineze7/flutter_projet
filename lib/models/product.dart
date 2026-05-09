class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String? imageUrl;
  final String category;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.imageUrl,
    required this.category,
  });



  factory Product.fromJson(Map<String, dynamic> json) {
    // Supporte le format TVMaze (clés 'title', 'description', 'genre', 'categorie', 'image', 'price')
    // ET le format de stockage interne produit par toJson() (clés 'title', 'description', 'price', etc.)

    final images = json['images'] as List<dynamic>?;

    return Product(
      id: json['id'] as int,
      title: json['title'] as String? ?? 'Sans titre',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      imageUrl: images != null && images.isNotEmpty
          ? images[0] as String
          : json['imageUrl'] as String?,
      category: json['category'] is Map
          ? json['category']['name'] as String? ?? 'Inconnu'
          : json['category'] as String? ?? 'Inconnu',
    );
  } 

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'category': category,
      };

  @override
  bool operator ==(Object other) => other is Product && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
