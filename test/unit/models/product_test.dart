import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_projet/models/product.dart';

void main() {
  group('Product', () {
    final jsonComplet = {
      'id': 1,
      'title': 'iPhone 15',
      'description': 'Smartphone Apple',
      'price': 999.99,
      'images': ['https://example.com/iphone.jpg'],
      'category': {'name': 'Tech'},
    };

    test('fromJson crée un Product correctement', () {
      final product = Product.fromJson(jsonComplet);

      expect(product.id, 1);
      expect(product.title, 'iPhone 15');
      expect(product.description, 'Smartphone Apple');
      expect(product.price, 999.99);
      expect(product.imageUrl, 'https://example.com/iphone.jpg');
      expect(product.category, 'Tech');
    });

    test('fromJson gère les champs optionnels absents', () {
      final jsonMinimal = {
        'id': 2,
        'title': 'Test',
        'description': '',
        'price': 10,
      };

      final product = Product.fromJson(jsonMinimal);

      expect(product.imageUrl, isNull);
      expect(product.category, 'Inconnu');
      expect(product.title, 'Test');
    });

    test('toJson / fromJson sont symétriques', () {
      final original = Product.fromJson(jsonComplet);
      final reconstruit = Product.fromJson(original.toJson());

      expect(reconstruit.id, original.id);
      expect(reconstruit.title, original.title);
      expect(reconstruit.price, original.price);
      expect(reconstruit.category, original.category);
    });
  });
}