class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String category;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
  });



  factory Product.fromJson(Map<String, dynamic> json) {
    // Supporte le format TVMaze (clés 'title', 'description', 'genre', 'categorie', 'image', 'price')
    // ET le format de stockage interne produit par toJson() (clés 'title', 'description', 'price', etc.)
    return Product(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      image: json['images'] != null
          ? json['images'][0]
          : json['image'] ?? '',
      category: json['category'] != null
          ? json['category']['name'] ?? 'Inconnu'
          : 'Inconnu',
      
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'price': price,
    'image': image,
    'category': category,
  };

  @override
  bool operator ==(Object other) => other is Product && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
