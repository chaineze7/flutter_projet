import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductListe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => context.go('/favoris'),
          ),
          // bonus : badge itemCount sur le panier
          Consumer<CartProvider>(
            builder: (context, cartProvider, _) => Badge(
              isLabelVisible: cartProvider.itemCount > 0,
              label: Text(cartProvider.itemCount.toString()),
              child: IconButton(
                icon: const Icon(Icons.shooping_cart),
                onPressed: () => context.go('/cart'),
              ),
            ),
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) {

          // loading
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // erreur
          if (provider.error != null) {
            return Center(
              child: Text(provider.error!),
            );
          }

          // liste produits
          return ListView.builder(
            itemCount: provider.products.length,

            itemBuilder: (context, index) {

              final product = provider.products[index];

              return ListTile(

                leading: product.image.isNotEmpty
                    ? Image.network(
                        product.image,
                        width: 50,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.image),

                title: Text(product.title),

                subtitle: Text(product.category),

                trailing: Text(
                  '${product.price.toStringAsFixed(2)} €',
                ),

                onTap: () {
                  context.go('/product/${product.id}');
                },
              );
            },
          );
        },
      ),
    );
  }
}