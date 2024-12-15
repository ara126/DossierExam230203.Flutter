import 'package:flutter/material.dart';

class PageFavorite extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteProducts;

  const PageFavorite({super.key, required this.favoriteProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text("Produits Favoris",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: favoriteProducts.isEmpty
          ? const Center(child: Text("Aucun produit favori"))
          : ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = favoriteProducts[index];
          return ListTile(
            leading: Image.network(
              product['images']?.isNotEmpty == true
                  ? product['images'][0]['src']
                  : 'https://via.placeholder.com/150',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(product['name'] ?? "Produit inconnu"),
            subtitle: Text("${product['price'] ?? 'Non disponible'} FCFA"),
          );
        },
      ),
    );
  }
}
