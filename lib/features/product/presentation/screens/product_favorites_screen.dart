import 'package:flutter/material.dart';
import 'product_screen.dart';

class ProductFavoritesScreen extends StatelessWidget {
  final List<Product> favoriteProducts;
  final Function(Product) onToggleFavorite;
  final Function(Product) onAddToCart;

  const ProductFavoritesScreen({
    super.key,
    required this.favoriteProducts,
    required this.onToggleFavorite,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
          child: Text(
            'My Favorites',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Expanded(
          child: favoriteProducts.isEmpty
              ? const Center(
                  child: Text('No favorite items added yet!', style: TextStyle(color: Colors.grey)),
                )
              : ListView.builder(
                  itemCount: favoriteProducts.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    final product = favoriteProducts[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF141414),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withOpacity(0.05)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF090909),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.network(product.img, fit: BoxFit.contain),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                                Text(product.sub, style: const TextStyle(fontSize: 11, color: Color(0xFF8E8E93))),
                                Text('\$${product.price.toStringAsFixed(0)}.00', style: const TextStyle(color: Color(0xFFFF3B00), fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                            onPressed: () => onAddToCart(product),
                          ),
                          IconButton(
                            icon: const Icon(Icons.favorite, color: Color(0xFFFF3B00)),
                            onPressed: () => onToggleFavorite(product),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
