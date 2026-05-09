import 'package:flutter_test/flutter_test.dart';
import '../../mocks/mock_preferences_service.dart';
import '../../helpers/test_data.dart';

void main() {
  group('PreferencesService (Favoris)', () {

    test('getFavoris retourne une liste vide initialement', () async {
      final service = MockPreferencesService();

      final favoris = await service.getFavoris();

      expect(favoris, isEmpty);
    });

    test('saveFavoris puis getFavoris retourne les produits sauvegardés', () async {
      final service = MockPreferencesService();

      await service.saveFavoris([testProduct1, testProduct2]);

      final favoris = await service.getFavoris();

      expect(favoris[0].title, testProduct1.title);
      expect(favoris[1].title, testProduct2.title);
    });

    test('saveFavoris remplace les données précédentes', () async {
      final service = MockPreferencesService();

      await service.saveFavoris([testProduct1, testProduct2]);
      await service.saveFavoris([testProduct1]);

      final favoris = await service.getFavoris();

      expect(favoris.length, 1);
    });
  });
}