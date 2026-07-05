import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

/// DiscoverScreen displays a browsable list of products
/// 
/// Features include:
/// - Search bar for filtering products
/// - Promotional banner
/// - Grid view of products with 2 columns
/// - Add to Cart functionality with visual feedback
class DiscoverScreen extends StatefulWidget {
  /// Callback to add a product to the cart
  final Function(Product) onAddToCart;

  /// Current number of items in the cart
  final int cartItemCount;

  const DiscoverScreen({
    super.key,
    required this.onAddToCart,
    required this.cartItemCount,
  });

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  /// Mock product data - simulating API response from DummyJSON or FakeStore
  final List<Product> allProducts = [
    Product(
      id: 1,
      title: 'Kablosuz Kulaklık',
      description:
          'Yüksek kaliteli kablosuz kulaklık, aktif gürültü engelleme ve 30 saatlik pil ömrü sunar.',
      price: 149.99,
      image: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=300&q=80',
      rating: 4.5,
      category: 'Elektronik',
      stock: 45,
      specifications: {
        'Pil Ömrü': '30 saat',
        'Gürültü Engelleme': 'Aktif',
        'Bağlantı': 'Bluetooth 5.0',
      },
    ),
    Product(
      id: 2,
      title: 'Profesyonel Seyahat Çantası',
      description:
          'Seyahat edenler ve profesyoneller için dayanıklı, geniş ve birden fazla bölmeli seyahat çantası.',
      price: 89.99,
      image: 'https://images.unsplash.com/photo-1622560480605-d83c853bc5c3?auto=format&fit=crop&w=300&q=80',
      rating: 4.2,
      category: 'Seyahat',
      stock: 30,
      specifications: {
        'Malzeme': 'Naylon',
        'Kapasite': '40L',
        'Su Geçirmez': 'Evet',
      },
    ),
    Product(
      id: 3,
      title: 'Akıllı Saat',
      description:
          'Sağlık takibi ve bağlantı özellikleriyle dolu güçlü bir akıllı saat.',
      price: 199.99,
      image: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=300&q=80',
      rating: 4.7,
      category: 'Elektronik',
      stock: 25,
      specifications: {
        'Ekran': 'AMOLED',
        'Pil': '5 gün',
        'Su Direnci': '5ATM',
      },
    ),
    Product(
      id: 4,
      title: 'Deri Cüzdan',
      description: 'RFID korumalı, şık ve doğal deri tasarıma sahip cüzdan.',
      price: 59.99,
      image: 'https://images.unsplash.com/photo-1627123424574-724758594e93?auto=format&fit=crop&w=300&q=80',
      rating: 4.3,
      category: 'Aksesuar',
      stock: 60,
      specifications: {
        'Malzeme': 'Doğal Deri',
        'RFID': 'Korunmuş',
        'Bölmeler': '8',
      },
    ),
    Product(
      id: 5,
      title: 'Taşınabilir Telefon Şarj Cihazı',
      description:
          '25000mAh kapasiteye sahip, hızlı şarj eden ve çoklu bağlantı noktası bulunan taşınabilir şarj cihazı.',
      price: 34.99,
      image: 'https://images.unsplash.com/photo-1609091839311-d5365f9ff1c5?auto=format&fit=crop&w=300&q=80',
      rating: 4.6,
      category: 'Elektronik',
      stock: 80,
      specifications: {
        'Kapasite': '25000mAh',
        'Bağlantı Noktaları': '3 USB',
        'Hızlı Şarj': 'Evet',
      },
    ),
    Product(
      id: 6,
      title: 'Profesyonel Kamera Tripodu',
      description: 'Fotoğrafçılar ve videografçılar için dayanıklı ve hafif kamera tripodu.',
      price: 79.99,
      image: 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?auto=format&fit=crop&w=300&q=80',
      rating: 4.4,
      category: 'Fotoğrafçılık',
      stock: 20,
      specifications: {
        'Malzeme': 'Alüminyum',
        'Maksimum Yükseklik': '160cm',
        'Yük Kapasitesi': '3kg',
      },
    ),
    Product(
      id: 7,
      title: 'Kablosuz Klavye',
      description: 'Uzun pil ömrü ve sessiz tuşlarla rahat kullanım sunan kablosuz klavye.',
      price: 49.99,
      image: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=300&q=80',
      rating: 4.1,
      category: 'Elektronik',
      stock: 40,
      specifications: {
        'Bağlantı': 'Kablosuz 2.4GHz',
        'Pil': '2 ay',
        'Tuş Tipi': 'Sessiz Tuşlar',
      },
    ),
    Product(
      id: 8,
      title: 'Mavi Işık Gözlüğü',
      description:
          'Ekran süresinde göz yorgunluğunu azaltan, mavi ışığı filtreleyen şık gözlük.',
      price: 44.99,
      image: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=300&q=80',
      rating: 4.0,
      category: 'Aksesuar',
      stock: 55,
      specifications: {
        'Lens': 'Yansıtma Önleyici',
        'Mavi Işık': '%80 Engelleme',
        'Çerçeve': 'TR90',
      },
    ),
  ];

  /// Filtered list of products based on search
  late List<Product> filteredProducts;

  /// Search controller for the search field
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    filteredProducts = allProducts;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Filters products based on search query
  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProducts = allProducts;
      } else {
        filteredProducts = allProducts
            .where((product) =>
                product.title.toLowerCase().contains(query.toLowerCase()) ||
                product.category.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Keşfet',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          /// Cart Icon with Badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag),
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
              ),

          /// Cart Item Count Badge
          if (widget.cartItemCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 24,
                  minHeight: 24,
                ),
                child: Text(
                  widget.cartItemCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Search Bar Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                onChanged: _filterProducts,
                decoration: InputDecoration(
                  hintText: 'Ürün ara...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.deepPurple,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
            ),

            /// Promotional Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.deepPurple, Colors.purple[300]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.local_offer,
                          size: 48,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Özel Teklif',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'İndirimler %50’ye kadar',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            /// Section Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Öne Çıkan Ürünler (${filteredProducts.length})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),

            /// Products Grid View
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: filteredProducts.isEmpty
                  ? SizedBox(
                      height: 300,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 48,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Ürün bulunamadı',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return ProductCard(
                          product: product,
                          onAddToCart: () {
                            widget.onAddToCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.title} sepete eklendi'),
                                duration: const Duration(seconds: 1),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/detail',
                              arguments: product,
                            );
                          },
                        );
                      },
                    ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
