import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_projet/models/product.dart';
import 'package:flutter_projet/providers/cart_provider.dart';
import 'package:flutter_projet/services/cart_database_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  late CartDatabaseService dbService;
  late CartProvider provider;

  final testProduct = Product(
    id: 1,
    title: 'Test',
    description: 'desc',
    price: 10,
    imageUrl: null,
    category: 'cat',
  );

  setUp(() async {
    dbService = CartDatabaseService(databasePath: inMemoryDatabasePath);
    provider = CartProvider(dbService: dbService);

    await Future.delayed(const Duration(milliseconds: 20));
  });

  group('CartProvider', () {

    test('démarre avec un panier vide', () {
      expect(provider.items, isEmpty);
      expect(provider.itemCount, 0);
    });

    test('ajouterProduit ajoute un produit', () async {
      await provider.ajouterProduit(testProduct);

      expect(provider.items.length, 1);
      expect(provider.items.first.product.id, 1);
      expect(provider.items.first.quantity, 1);
    });

    test('ajouterProduit incrémente si déjà présent', () async {
      await provider.ajouterProduit(testProduct);
      await provider.ajouterProduit(testProduct);

      expect(provider.items.length, 1);
      expect(provider.items.first.quantity, 2);
    });

    test('retirerProduit supprime le produit', () async {
      await provider.ajouterProduit(testProduct);

      await provider.retirerProduit(testProduct.id);

      expect(provider.items, isEmpty);
    });
  });
}