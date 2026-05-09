import 'package:flutter_projet/models/product.dart';
import 'package:flutter_projet/services/preferences_service.dart';

class MockPreferencesService extends PreferencesService {
  List<Product> _favoris = [];

  @override
  Future<List<Product>> getFavoris() async => List.from(_favoris);

  @override
  Future<void> saveFavoris(List<Product> favoris) async {
    _favoris = List.from(favoris);
  }
}
