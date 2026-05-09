import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/favoris_provider.dart';

class FavorisScreen extends StatelessWidget {
  const FavorisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mes favoris')),
      body: Consumer<FavorisProvider>(
        builder: (context, provider, _) {
          if (provider.favoris.isEmpty) {
            return const Center(child: Text('Aucun favori pour l\'instant.'));
          }
          return ListView.builder(
            itemCount: provider.favoris.length,
            itemBuilder: (context, index) {
              final product = provider.favoris[index];
              return ListTile(
                leading: product.imageUrl != null
                    ? Image.network(product.imageUrl!, width: 50,
                    errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported);
                    },
                  )
                    : const Icon(Icons.shopping_bag),
                title: Text(product.title),
                subtitle: Text(product.category),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () => context.read<FavorisProvider>().toggleFavori(product),
                ),
                onTap: () => context.go('/product/${product.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
