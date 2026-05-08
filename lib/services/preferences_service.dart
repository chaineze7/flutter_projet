import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class PreferencesService {
  static const _favorisKey = 'favoris';

  Future<List<Product>> getFavoris() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_favorisKey);
    if (jsonStr == null) return [];

    final List<dynamic> data = jsonDecode(jsonStr);
    return data.map((j) => Product.fromJson(j)).toList();
  }

  Future<void> saveFavoris(List<Product> favoris) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(favoris.map((p) => p.toJson()).toList());
    await prefs.setString(_favorisKey, jsonStr);
  }
}
