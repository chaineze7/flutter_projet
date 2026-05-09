import 'package:flutter_projet/models/product.dart';

final testProduct1 = Product(
  id: 1,
  title: 'Sleek White & Orange Wireless Gaming Controller',
  description: 'Elevate your gaming experience with this state-of-the-art wireless controller, featuring a crisp white base with vibrant orange accents. Designed for precision play, the ergonomic shape and responsive buttons provide maximum comfort and control for endless hours of gameplay. Compatible with multiple gaming platforms, this controller is a must-have for any serious gamer looking to enhance their setup.',
  price: 69,
  imageUrl: 'https://example.com/jeux.jpg',
  category: 'Electronics',
);

final testProduct2 = Product(
  id: 2,
  title: 'Sleek Wireless Headphone & Inked Earbud Set',
  description: 'Experience the fusion of style and sound with this sophisticated audio set featuring a pair of sleek, white wireless headphones offering crystal-clear sound quality and over-ear comfort. The set also includes a set of durable earbuds, perfect for an on-the-go lifestyle. Elevate your music enjoyment with this versatile duo, designed to cater to all your listening needs.',
  price: 44,
  imageUrl: 'https://example.com/jsp.jpg',
  category: 'Electronics',
  
);
final mockProductsJson = [
  {
    'id': 1,
    'title': 'Sleek White & Orange Wireless Gaming Controller',
    'description': 'Elevate your gaming experience...',
    'price': 69,
    'imageUrl': 'https://example.com/jeux.jpg',
    'category': 'Electronics',
  },
  {
    'id': 2,
    'title': 'Sleek Wireless Headphone & Inked Earbud Set',
    'description': 'Experience the fusion of style and sound...',
    'price': 44,
    'imageUrl': 'https://example.com/jsp.jpg',
    'category': 'Electronics',
  },
];