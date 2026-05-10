// services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Service de gestion de l'authentification utilisateur
class AuthService {
  
  final String baseUrl = "https://api.escuelajs.co/api/v1";
  

  String? _token;

  bool get isAuthenticated => _token != null;
  String? get token => _token;

  
  Future<void> init() async {
    await loadToken();
  }

  
  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
    print("Token chargé depuis le stockage : $_token");
  }

  // Envoie une requete POST pour connecter un utilisateur
  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

     
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        
        _token = data["access_token"];
        
        
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', _token!);
        
        return true;
      } else {
        print("Erreur Login: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (e) {
      print("Erreur réseau Login: $e");
      return false;
    }
  }

  Future<bool> register( String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/users/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": "Utilisateur",
          "email": email,
          "password": password,
          "avatar": "https://picsum.photos/800" 
        }),
      );
      
      if (response.statusCode == 201) {
        
        return await login(email, password);
      } else {
        print("Erreur Register: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (e) {
      print("Erreur réseau Register: $e");
      return false;
    }
  }

  
  Future<void> logout() async {
    
    _token = null;
    
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}


final authService = AuthService();