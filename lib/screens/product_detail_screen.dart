import 'package:flutter/material.dart';
import '../models/product.dart';

/// ProductDetailScreen displays detailed information about a selected product
/// 
/// Features include:
/// - Large product image at the top
/// - Scrollable content area with product details
/// - Description and specifications sections
/// - Add to Cart button with visual feedback
class ProductDetailScreen extends StatelessWidget {
  /// The product to display details for
  final Product product;

  /// Callback to add the product to cart
  final Function(Product) onAddToCart;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Ürün Detayı',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image Section
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Container(
                width: double.infinity,
                height: 300,
                color: Colors.grey[200],
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                  headers: const {'User-Agent': 'Mozilla/5.0'},
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey[400],
                        size: 60,
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),

            /// Product Information Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Product Title
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),

                  /// Rating and Stock Status Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Rating Display
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              product.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// Stock Status
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: product.stock > 0
                              ? Colors.green.withValues(alpha: 0.2)
                              : Colors.red.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          product.stock > 0
                              ? '${product.stock} stokta'
                              : 'Stokta yok',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: product.stock > 0
                                ? Colors.green[700]
                                : Colors.red[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// Price Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Fiyat',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '₺${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  /// Category
                  Row(
                    children: [
                      Icon(
                        Icons.category,
                        color: Colors.deepPurple,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Kategori: ${product.category}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  /// Description Section
                  const Text(
                    'Açıklama',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),

                  /// Specifications Section
                  const Text(
                    'Teknik Özellikler',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: product.specifications.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'Teknik özellik yok',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          )
                        : Column(
                            children: List.generate(
                              product.specifications.length,
                              (index) {
                                final entries =
                                    product.specifications.entries.toList();
                                final entry = entries[index];
                                final isLast =
                                    index == product.specifications.length - 1;

                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            entry.key,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            entry.value,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (!isLast)
                                      Divider(
                                        color: Colors.grey[300],
                                        height: 0,
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),

      /// Floating Add to Cart Button
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 16,
          bottom: MediaQuery.of(context).padding.bottom + 16,
        ),
        child: ElevatedButton(
          onPressed: product.stock > 0
              ? () {
                  onAddToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${product.title} sepete eklendi',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            disabledBackgroundColor: Colors.grey[400],
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            product.stock > 0 ? 'Sepete Ekle' : 'Stokta Yok',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
