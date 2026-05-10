import 'package:go_router/go_router.dart';
import 'screens/product_list_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/favoris_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';


// Configuration des routes de l'application
final router = GoRouter(

  // Premiere page affichée au lancement
  initialLocation: '/login',

  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductListScreen(),

      routes: [
        GoRoute(
          path: 'product/:id',

          builder: (context, state) {
            final id = int.parse(
              state.pathParameters['id']!,
            );

            return ProductDetailScreen(
              productId: id,
            );
          },
        ),

        GoRoute(
          path: 'favoris',
          builder: (context, state) =>
              const FavorisScreen(),
        ),

        GoRoute(
          path: 'cart',
          builder: (context, state) =>
              const CartScreen(),
        ),
      ],
    ),

    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),

    GoRoute(
      path: '/register',
      builder: (context, state) =>  RegisterScreen(),
    ),
  ],
);