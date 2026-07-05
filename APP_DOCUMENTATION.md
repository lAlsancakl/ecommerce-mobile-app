# E-Commerce Flutter Mobile Application

A complete, production-ready Flutter e-commerce application built with **only** native Material Design widgets and no external state management packages. This app demonstrates best practices for mobile app development using Flutter.

## 📋 Project Overview

This is a fully functional e-commerce application featuring:
- Product discovery with search functionality
- Detailed product information screens
- Shopping cart management
- Price calculations with discounts
- Clean UI/UX design using Material Design 3

**Technology Stack:**
- **Framework:** Flutter
- **UI Library:** Material (package:flutter/material.dart)
- **State Management:** Native `setState`
- **Navigation:** Named routes with `Navigator`
- **Null Safety:** Full null safety compliance

---

## 📁 Project Architecture

### Directory Structure

```
lib/
├── main.dart                          # Application entry point & routing
├── models/
│   └── product.dart                   # Product data model with JSON serialization
├── screens/
│   ├── discover_screen.dart           # Home screen with product discovery
│   ├── product_detail_screen.dart    # Detailed product information
│   └── cart_screen.dart               # Shopping cart management
└── widgets/
    └── product_card.dart             # Reusable product card widget
```

---

## 🎯 Core Features

### 1. **DiscoverScreen** (`lib/screens/discover_screen.dart`)

The home screen of the application featuring:

- **Search Bar:** Filters products by title or category in real-time
- **Promotional Banner:** Eye-catching visual banner with offer information
- **Product Grid:** Two-column responsive grid layout using `GridView.builder`
- **Product Cards:** Each card displays:
  - Product image (with `ClipRRect` rounded corners)
  - Product title
  - Star rating
  - Price
  - Add to Cart button
- **Cart Badge:** Displays current cart item count on the app bar
- **Search Results:** Shows the number of products found

**Key Features:**
- Real-time product filtering by name or category
- Visual feedback when adding items to cart
- Responsive design with proper spacing and layout
- Error handling for image loading failures

### 2. **ProductDetailScreen** (`lib/screens/product_detail_screen.dart`)

Comprehensive product details display featuring:

- **Large Product Image:** Full-width image with rounded corners
- **Product Information:**
  - Title, price, and category
  - Star rating and stock status
  - Color-coded stock availability (green for in stock, red for out)
- **Description Section:** Detailed product description
- **Specifications Section:** Product specifications displayed in an interactive list
- **Scrollable Content:** `SingleChildScrollView` prevents layout overflow
- **Fixed Checkout Button:** Prominent button at the bottom of the screen
- **Add to Cart Functionality:** Visual feedback on successful addition

**Key Features:**
- Argument passing via `ModalRoute.of(context)!.settings.arguments`
- Professional card-based layout for information organization
- Color-coded stock status indicators
- Specifications organized in collapsible card format

### 3. **CartScreen** (`lib/screens/cart_screen.dart`)

Complete shopping cart management featuring:

- **Empty Cart State:** 
  - Large shopping cart icon
  - Friendly message: "Your cart is empty"
  - Call-to-action text
  
- **Filled Cart State:**
  - List of cart items using `ListView.builder`
  - Each item displays:
    - Product image (100x100 preview)
    - Product title and category
    - Star rating
    - Price
    - Delete button

- **Cart Summary Section (Fixed Bottom):**
  - Subtotal calculation
  - 10% discount calculation
  - Final total price
  - Item count

- **Checkout Button:**
  - Opens order confirmation dialog
  - Shows full order summary
  - Confirms order placement
  - Visual feedback with success message

**Key Features:**
- Dynamic empty/filled state switching
- Real-time price calculations
- Item removal with confirmation feedback
- Professional checkout flow with order review dialog

---

## 🔄 State Management

### Architecture

The app uses **native Flutter `setState`** for state management. All cart-related state is managed at the root widget level (`MyApp` → `_MyAppState`).

### State Flow

1. **Root Level State** (`lib/main.dart`):
   ```dart
   class _MyAppState extends State<MyApp> {
     final List<Product> cartItems = [];
     
     void _addToCart(Product product) {
       setState(() => cartItems.add(product));
     }
     
     void _removeFromCart(int index) {
       setState(() => cartItems.removeAt(index));
     }
   }
   ```

2. **Callbacks to Child Widgets:**
   - `onAddToCart`: Passes add-to-cart functionality to screens
   - `onRemoveItem`: Passes remove functionality to cart screen
   - `cartItemCount`: Displays current cart size in app bar

3. **Automatic UI Updates:**
   - When `setState()` is called, the app rebuilds all widgets
   - Cart count updates instantly in app bar
   - Cart screen reflects item additions/removals

---

## 🛣️ Navigation & Routing

### Named Routes Configuration

Routes are defined in `lib/main.dart` using `onGenerateRoute`:

| Route | Screen | Purpose |
|-------|--------|---------|
| `/` | DiscoverScreen | Home/discovery screen |
| `/detail` | ProductDetailScreen | Product details (with Product argument) |
| `/cart` | CartScreen | Shopping cart |

### Navigation Examples

**Navigate to Product Details:**
```dart
Navigator.pushNamed(
  context,
  '/detail',
  arguments: product,  // Pass Product object
);
```

**Retrieve Arguments:**
```dart
final product = ModalRoute.of(context)!.settings.arguments as Product;
```

**Navigate to Cart:**
```dart
Navigator.pushNamed(context, '/cart');
```

---

## 📦 Data Model

### Product Model (`lib/models/product.dart`)

Complete product data structure with JSON serialization:

```dart
class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final double rating;
  final String category;
  final int stock;
  final Map<String, String> specifications;

  // JSON Deserialization
  factory Product.fromJson(Map<String, dynamic> json) { ... }

  // JSON Serialization
  Map<String, dynamic> toJson() { ... }

  // Copy constructor for immutability
  Product copyWith({ ... }) { ... }
}
```

### Mock Data

Products are embedded directly in `DiscoverScreen` as a local JSON-like structure, simulating API responses from:
- DummyJSON (`https://dummyjson.com/products`)
- Fake Store API (`https://fakestoreapi.com/products`)

**Sample Products Included:**
1. Premium Wireless Headphones ($149.99)
2. Professional Backpack ($89.99)
3. Smart Watch Elite ($199.99)
4. Premium Leather Wallet ($59.99)
5. Portable Phone Charger ($34.99)
6. Professional Camera Tripod ($79.99)
7. Wireless Keyboard ($49.99)
8. Blue Light Glasses ($44.99)

---

## 🎨 UI Components

### ProductCard Widget (`lib/widgets/product_card.dart`)

Reusable component for displaying products:

- **Features:**
  - Image display with rounded corners and loading indicator
  - Product information layout
  - Price display in green
  - Star rating badge
  - Add-to-cart button with icon
  - Error handling for image loading failures

- **Callbacks:**
  - `onTap`: Navigate to product details
  - `onAddToCart`: Add product to cart with feedback

### Theme Configuration

Professional Material Design 3 theme with:

- **Color Scheme:**
  - Primary: Deep Purple
  - Secondary: Amber (for ratings)
  - Success: Green (for prices)
  - Error: Red (for delete/out of stock)

- **Typography:**
  - Clear hierarchy with display, body, and label text styles
  - Proper line heights for readability

- **Component Themes:**
  - Rounded button corners (8dp)
  - Consistent card elevation
  - Standard input field styling

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK installed
- Dart SDK (included with Flutter)
- A mobile device or emulator

### Installation

1. **Clone/Open the project:**
   ```bash
   cd first_app
   ```

2. **Get dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the application:**
   ```bash
   flutter run
   ```

### Build Options

```bash
# Build for Android
flutter build apk

# Build for iOS
flutter build ios

# Build for Web
flutter build web

# Build for Windows/Linux/macOS
flutter build windows
flutter build linux
flutter build macos
```

---

## ✅ Code Quality

### Null Safety

The entire codebase is null-safe with:
- Non-null types by default
- Proper null checking where needed
- No late-initialization issues

### Testing

Run code analysis:
```bash
flutter analyze lib/
```

Format code:
```bash
dart format lib/
```

---

## 📝 Key Implementation Details

### 1. Search Filtering
```dart
filteredProducts = allProducts.where((product) =>
  product.title.toLowerCase().contains(query.toLowerCase()) ||
  product.category.toLowerCase().contains(query.toLowerCase())
).toList();
```

### 2. Price Calculations
```dart
double get totalPrice => 
  cartItems.fold(0, (sum, product) => sum + product.price);

double get totalSavings => 
  cartItems.fold(0, (sum, product) => sum + (product.price * 0.1));
```

### 3. Dynamic Widget Switching
```dart
body: cartItems.isEmpty 
  ? _buildEmptyCart()
  : _buildFilledCart(context),
```

### 4. Image Error Handling
```dart
errorBuilder: (context, error, stackTrace) {
  return Center(
    child: Icon(
      Icons.image_not_supported,
      color: Colors.grey[400],
      size: 40,
    ),
  );
},
```

---

## 🔒 Constraints & Limitations

This application intentionally adheres to strict requirements:

✅ **Allowed:**
- Native Material Design widgets only
- `setState` for state management
- Named route navigation
- Built-in Material components

❌ **Not Allowed:**
- External state management packages (Provider, BLoC, Riverpod, GetX)
- Third-party routing packages
- Non-Material UI libraries
- External dependency injection frameworks

---

## 📱 Supported Platforms

- ✅ Android (API 21+)
- ✅ iOS (11.0+)
- ✅ Windows
- ✅ macOS
- ✅ Linux
- ✅ Web

---

## 🎓 Learning Resources

This project demonstrates:

1. **State Management:** Native `setState` pattern
2. **Navigation:** Named routes and argument passing
3. **UI/UX:** Material Design best practices
4. **Data Modeling:** JSON serialization with `fromJson`/`toJson`
5. **Responsive Design:** Adaptive layouts with GridView
6. **Error Handling:** Network image loading with fallbacks
7. **Code Organization:** Feature-based folder structure

---

## 📄 License

This project is provided as-is for educational and commercial use.

---

## 🚦 Future Enhancement Ideas

Potential additions while maintaining constraints:

- Local database integration (sqflite)
- Payment gateway integration (Stripe, PayPal)
- Order history tracking
- User authentication
- Product reviews and ratings
- Wishlist functionality
- Multiple categories with filtering
- Product sorting options
- Inventory management
- Order tracking

---

## ✨ Summary

This is a **complete, production-ready Flutter e-commerce application** that:

- ✅ Uses **only Material widgets** - no external UI libraries
- ✅ Implements **native state management** - no external packages
- ✅ Features **proper navigation** with named routes
- ✅ Demonstrates **professional code organization**
- ✅ Follows **Dart/Flutter best practices**
- ✅ Maintains **full null safety**
- ✅ Includes **comprehensive documentation**
- ✅ Provides **multiple screens** with distinct functionality
- ✅ Shows **real-world patterns** like filtering, calculations, and error handling

The application is ready for immediate deployment and serves as an excellent reference for Flutter development practices.
