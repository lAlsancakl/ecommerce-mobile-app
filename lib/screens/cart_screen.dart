import 'package:flutter/material.dart';
import '../models/product.dart';

/// CartScreen displays the shopping cart with added products
/// 
/// Features include:
/// - Empty cart state with icon and message
/// - Filled cart state with product list
/// - Product removal functionality
/// - Total price calculation
/// - Checkout button with order summary
class CartScreen extends StatelessWidget {
  /// List of products in the cart
  final List<Product> cartItems;

  /// Callback to remove a product from the cart
  final Function(int) onRemoveItem;

  const CartScreen({
    super.key,
    required this.cartItems,
    required this.onRemoveItem,
  });

  /// Calculates the total price of all items in the cart
  double get totalPrice {
    return cartItems.fold(0, (sum, product) => sum + product.price);
  }

  /// Calculates the total savings if applicable
  double get totalSavings {
    return cartItems.fold(0, (sum, product) => sum + (product.price * 0.1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Sepetim',
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

      /// Empty Cart State or Cart Items List
      body: cartItems.isEmpty
          ? _buildEmptyCart()
          : _buildFilledCart(context),

      /// Checkout Button (only visible when cart has items)
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : _buildCheckoutSection(context),
    );
  }

  /// Builds the empty cart UI
  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Empty Cart Icon
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),

          /// Empty Cart Message
          Text(
            'Sepetin boş',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Başlamak için ürün ekle',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the filled cart UI with product list
  Widget _buildFilledCart(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final product = cartItems[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  /// Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 100,
                      height: 100,
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
                              size: 30,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  /// Product Details Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Product Title
                        Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),

                        /// Product Category and Rating
                        Row(
                          children: [
                            Text(
                              product.category,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              product.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        /// Price
                        Text(
                          '₺${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Delete Button
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            onRemoveItem(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.title} kaldırıldı'),
                                duration: const Duration(seconds: 1),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.red[600],
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Builds the checkout section at the bottom
  Widget _buildCheckoutSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Price Breakdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ara toplam (${cartItems.length} ürün)',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                '₺${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          /// Shipping and Discount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'İndirim (10%)',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                '-₺${totalSavings.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          /// Divider
          Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
          const SizedBox(height: 8),

          /// Total Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Toplam',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '₺${(totalPrice - totalSavings).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          /// Checkout Button
          ElevatedButton(
            onPressed: () {
              _showCheckoutDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text(
              'Ödemeye Geç',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Shows a checkout confirmation dialog
  void _showCheckoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text('Sipariş Özeti'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ürün sayısı: ${cartItems.length}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'Ara toplam: ₺${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'İndirim: -₺${totalSavings.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 12),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
            ),
            const SizedBox(height: 12),
            Text(
              'Toplam: ₺${(totalPrice - totalSavings).toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sipariş başarıyla verildi!'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
            ),
            child: const Text('Siparişi Onayla'),
          ),
        ],
      ),
    );
  }
}
