import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'providers/product_provider.dart';
import 'providers/favoris_provider.dart';
import 'providers/cart_provider.dart';
import 'router.dart';

final supabase = Supabase.instance.client;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Connexion à Supabase
  await Supabase.initialize(
    url:'https://ymgqdivquwmvbzmzjowz.supabase.co',
    anonKey:'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InltZ3FkaXZxdXdtdmJ6bXpqb3d6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzc4MTEzOTcsImV4cCI6MjA5MzM4NzM5N30.c7lAG-yRodJsJ8vNmHbol4AX9_uUSAt3EbsP2Rl1Xtw',
  );

  // Injection des providers dans toute l'application
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => FavorisProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ProductListe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
