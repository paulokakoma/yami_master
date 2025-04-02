import 'package:flutter/material.dart';
import '../../../domain/entities/product.dart';
import '../product/product_details_page.dart';
import '../product/widgets/product_card.dart';

class FavoritesPage extends StatelessWidget {
  final List<Product> favoriteProducts;
  final Function(Product) onAddToFavorites;
  final Function(Product, int) onAddToCart;

  const FavoritesPage({
    super.key,
    required this.favoriteProducts,
    required this.onAddToFavorites,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: favoriteProducts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum produto favorito',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(
                          product: product,
                          onAddToFavorites: () => onAddToFavorites(product),
                          onAddToCart: (quantity) =>
                              onAddToCart(product, quantity),
                          isFavorite: true,
                        ),
                      ),
                    );
                  },
                  child: ProductCard(
                    product: product,
                  ),
                );
              },
            ),
    );
  }
}
