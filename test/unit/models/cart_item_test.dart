import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_projet/models/cart_item.dart';
import 'package:flutter_projet/models/product.dart';

void main() {
  group('CartItem', () {
    final product = Product(
      id: 1,
      title: 'Test product',
      description: 'desc',
      price: 10.0,
      imageUrl: 'https://test.com/image.png',
      category: 'test',
    );

    test('quantité par défaut = 1', () {
      final item = CartItem(product: product);

      expect(item.quantity, 1);
    });

    test('toJson / fromJson sont symétriques', () {
      final original = CartItem(
        product: product,
        quantity: 2,
      );

      final json = original.toJson();
      final reconstruit = CartItem.fromJson(json);

      expect(reconstruit.product.id, original.product.id);
      expect(reconstruit.quantity, original.quantity);
    });

    test('augmentation quantité fonctionne', () {
      final item = CartItem(product: product, quantity: 1);

      item.quantity++;

      expect(item.quantity, 2);
    });
  });
}