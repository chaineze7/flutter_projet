import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  void _handleRegister() async {

    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Veuillez remplir tous les champs"),
        ),
      );

      return;
    }

    setState(() => _isLoading = true);

    bool success = await authService.register(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (success) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Compte créé avec succès"),
          backgroundColor: Colors.green,
        ),
      );

      context.go('/login');

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erreur lors de l'inscription"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Color(0xFF0D47A1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Container(

              padding: const EdgeInsets.all(25),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),

                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [

                  const Icon(
                    Icons.person_add,
                    size: 60,
                    color: Colors.blue,
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Créer un compte",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),


                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,

                    decoration: InputDecoration(
                      hintText: "Email",

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),

                      prefixIcon: const Icon(Icons.email),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: _passwordController,
                    obscureText: true,

                    decoration: InputDecoration(
                      hintText: "Mot de passe",

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),

                      prefixIcon: const Icon(Icons.lock),
                    ),
                  ),

                  const SizedBox(height: 25),

                  _isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          height: 50,

                          child: ElevatedButton(

                            onPressed: _handleRegister,

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),

                            child: const Text(
                              "S'inscrire",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),

                  const SizedBox(height: 10),

                  TextButton(
                    onPressed: () {
                      context.go('/login');
                    },

                    child: const Text("Déjà un compte ? Connexion"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {

    
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }
}