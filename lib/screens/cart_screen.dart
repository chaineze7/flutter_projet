import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/cart_provider.dart'; 

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mon Panier')), // Titre adapté
      body: Consumer<CartProvider>(
        builder: (context, provider, _) {
          if (provider.items.isEmpty) {
            return const Center(child: Text('Votre panier est vide.'));
          }
          
          return ListView.builder(
            itemCount: provider.items.length,
            itemBuilder: (context, index) {
              final item = provider.items[index]; 
              
              return ListTile(
                
                leading: item.product.image.isNotEmpty
                    ? Image.network(item.product.image, width: 50)
                    : const Icon(Icons.shopping_bag),
                
                
                title: Text(item.product.title),
                
                
                subtitle: Text('${item.product.price.toStringAsFixed(2)} € x ${item.quantity}'),
                
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                   
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      
                      onPressed: () => provider.retirerProduit(item.product.id),
                    ),
                  ],
                ),
                
                onTap: () => context.go('/product/${item.product.id}'),
              );
            },
          );
        },
      ),
    );
  }
}