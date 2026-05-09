import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_projet/services/cart_database_service.dart';
import 'package:flutter_projet/models/cart_item.dart';
import 'package:flutter_projet/models/product.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('CartDatabaseService', () {
    late CartDatabaseService service;

    setUp(() {
      service = CartDatabaseService(databasePath: inMemoryDatabasePath);
    });

    test('vide au départ', () async {
      final data = await service.getCart();
      expect(data, isEmpty);
    });

    test('save puis get fonctionne', () async {
      final product = Product(
        id: 1,
        title: 'Test',
        description: '',
        price: 10,
        imageUrl: null,
        category: 'cat',
      );

      final item = CartItem(product: product, quantity: 2);

      await service.saveCart([item]);

      final data = await service.getCart();

      expect(data.length, 1);
      expect(data.first.quantity, 2);
    });
  });
}