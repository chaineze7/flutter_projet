import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart'; 
import '../providers/favoris_provider.dart'; 
import '../providers/cart_provider.dart';   

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détails du Produit')),
      body: FutureBuilder<Product>(
        future: context.read<ProductProvider>().fetchProductById(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Produit non trouvé'));
          }

          final product = snapshot.data!;

          return SingleChildScrollView( 
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image du produit avec le Hero tag corrigé
                if (product.imageUrl != null )
                  Center(
                    child: Hero(
                      tag: 'product_hero_${product.id}', 
                      child: Image.network(product.imageUrl!, height: 250, fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.image_not_supported,
                            size: 100,
                          );
                        },
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  product.category.toUpperCase(),
                  style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                
                Text(
                  '${product.price.toStringAsFixed(2)} €',
                  style: const TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                
                const Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(product.description),
                const SizedBox(height: 20),

                // Section Favoris
                Consumer<FavorisProvider>(
                  builder: (context, favorisProvider, _) {
                    final estFavori = favorisProvider.estFavori(product.id);
                    return ElevatedButton.icon(
                      onPressed: () => favorisProvider.toggleFavori(product),
                      icon: Icon(estFavori ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                      label: Text(estFavori ? 'Retirer des favoris' : 'Ajouter aux favoris'),
                    );
                  },
                ),
                const SizedBox(height: 8),

                // Section Panier (Adaptée à ton CartProvider)
                Consumer<CartProvider>( 
                  builder: (context, cartProvider, _) {
                    final estDansLePanier = cartProvider.estDansLePanier(product.id);
                    
                    return ElevatedButton.icon(
                      onPressed: () async {
                        if (estDansLePanier) {
                          await cartProvider.retirerProduit(product.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Produit retiré du panier'), duration: Duration(seconds: 1)),
                          );
                        } else {
                          await cartProvider.ajouterProduit(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Produit ajouté au panier'), duration: Duration(seconds: 1)),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: estDansLePanier ? Colors.orange : Colors.blue,
                        foregroundColor: Colors.white,
                        
                      ),
                      icon: Icon(estDansLePanier ? Icons.shopping_cart : Icons.add_shopping_cart),
                      label: Text(estDansLePanier ? 'Retirer du panier' : 'Ajouter au panier'),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}