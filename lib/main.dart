import 'package:flutter/material.dart';
import 'models/product.dart';
import 'screens/discover_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';

void main() {
  runApp(const MyApp());
}

/// Root widget of the e-commerce application
/// 
/// Implements state management for the shopping cart using native setState.
/// Manages named routes for navigation between screens without external packages.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// List to store products added to the shopping cart
  final List<Product> cartItems = [];

  /// Adds a product to the cart
  /// 
  /// Uses setState to trigger a rebuild and update the UI immediately
  void _addToCart(Product product) {
    setState(() {
      cartItems.add(product);
    });
  }

  /// Removes a product from the cart by index
  /// 
  /// Uses setState to trigger a rebuild and update the UI immediately
  void _removeFromCart(int index) {
    setState(() {
      if (index >= 0 && index < cartItems.length) {
        cartItems.removeAt(index);
      }
    });
  }

  /// Builds a route for the named routes
  /// 
  /// Handles route creation for all screens with proper argument passing
  Route<dynamic> _buildRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => DiscoverScreen(
            onAddToCart: _addToCart,
            cartItemCount: cartItems.length,
          ),
        );

      case '/detail':
        final product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(
            product: product,
            onAddToCart: _addToCart,
          ),
        );

      case '/cart':
        return MaterialPageRoute(
          builder: (_) => CartScreen(
            cartItems: cartItems,
            onRemoveItem: _removeFromCart,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Hata')),
            body: const Center(
              child: Text('Sayfa bulunamadı'),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Türk Market',
      debugShowCheckedModeBanner: false,

      /// App Theme Configuration
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),

        /// Text Theme
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            height: 1.5,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            height: 1.5,
          ),
        ),

        /// App Bar Theme
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),

        /// Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        /// Input Decoration Theme for Text Fields
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),

        /// Card Theme
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      /// Named Routes Configuration
      onGenerateRoute: _buildRoute,
      initialRoute: '/',
    );
  }
}
