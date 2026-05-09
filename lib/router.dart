import 'package:go_router/go_router.dart';
import 'screens/product_list_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/favoris_screen.dart';
import 'screens/cart_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductListScreen(),
      routes: [
        GoRoute(
          path: 'product/:id',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return ProductDetailScreen(productId: id);
          },
        ),
        GoRoute(
          path: 'favoris',
          builder: (context, state) => const FavorisScreen(),
        ),
        GoRoute(
          path: 'cart',
          builder: (context, state) => const CartScreen(),
        ),
      ],
    ),
  ],
);
