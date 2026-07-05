# Quick Start Guide

## 📚 Project Structure

```
lib/
├── main.dart                    # App root with routing & state management
├── models/
│   └── product.dart            # Product data model
├── screens/
│   ├── discover_screen.dart     # Home page with products
│   ├── product_detail_screen.dart # Product details
│   └── cart_screen.dart         # Shopping cart
└── widgets/
    └── product_card.dart       # Reusable product card
```

## 🎯 Key Files Overview

### `main.dart` - Application Entry Point
- **Purpose:** Root widget, routing setup, state management
- **State:** `cartItems` list (all cart products)
- **Methods:**
  - `_addToCart()`: Add product to cart
  - `_removeFromCart()`: Remove item by index
  - `_buildRoute()`: Handle navigation logic

### `models/product.dart` - Data Model
- **Class:** `Product`
- **Key Fields:** id, title, description, price, image, rating, category, stock, specifications
- **Methods:**
  - `fromJson()`: Parse JSON → Product
  - `toJson()`: Product → JSON
  - `copyWith()`: Create modified copy

### `screens/discover_screen.dart` - Home Screen
- **UI Elements:**
  - Search bar (filters by title/category)
  - Promotional banner
  - 2-column product grid
  - Cart badge on app bar
- **Functionality:**
  - Real-time product search
  - Add to cart with feedback
  - Navigate to product details

### `screens/product_detail_screen.dart` - Product Details
- **UI Elements:**
  - Large product image
  - Product info (title, price, stock, rating)
  - Detailed description
  - Specifications table
  - Fixed "Add to Cart" button
- **Functionality:**
  - Receive product via route arguments
  - Add to cart with confirmation

### `screens/cart_screen.dart` - Shopping Cart
- **UI States:**
  - Empty: Shopping cart icon + message
  - Filled: Product list with prices
- **Features:**
  - Item removal with confirmation
  - Price calculations (subtotal, discount 10%, total)
  - Order confirmation dialog
  - Checkout button

### `widgets/product_card.dart` - Product Card Component
- **Purpose:** Reusable card for displaying products
- **Props:**
  - `product`: The product to display
  - `onAddToCart`: Callback for add button
  - `onTap`: Callback for card tap (navigate)
- **Displays:** Image, title, rating, price, add button

---

## 🔄 State Management Flow

```
MyApp (Stateful)
  ├── cartItems[] (state)
  ├── _addToCart()
  ├── _removeFromCart()
  └── Routes:
      ├── DiscoverScreen (receives callbacks)
      ├── ProductDetailScreen (receives callbacks)
      └── CartScreen (receives cartItems list)
```

## 🛣️ Navigation Routes

```dart
// Home screen
Navigator.pushNamed(context, '/');

// Product details (with argument)
Navigator.pushNamed(context, '/detail', arguments: product);

// Cart screen
Navigator.pushNamed(context, '/cart');

// Go back
Navigator.pop(context);
```

---

## 🧪 Common Tasks

### Add a New Product

In `discover_screen.dart`, add to `allProducts` list:

```dart
Product(
  id: 9,
  title: 'Your Product Name',
  description: 'Product description here',
  price: 99.99,
  image: 'https://your-image-url.com/image.jpg',
  rating: 4.5,
  category: 'Category Name',
  stock: 50,
  specifications: {
    'Feature 1': 'Value 1',
    'Feature 2': 'Value 2',
  },
)
```

### Modify App Colors

In `main.dart`, update the theme:

```dart
theme: ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,  // Change this color
  ),
),
```

### Change Discount Percentage

In `cart_screen.dart`, update the discount calculation:

```dart
double get totalSavings {
  return cartItems.fold(0, (sum, product) => sum + (product.price * 0.15));  // 15% instead of 10%
}
```

### Add Product to Cart Programmatically

```dart
// In any screen, call:
widget.onAddToCart(product);
```

### Remove Item from Cart

```dart
// CartScreen handles this automatically via index
widget.onRemoveItem(index);
```

---

## 🎨 UI Components

### Build a Search Bar

```dart
TextField(
  decoration: InputDecoration(
    hintText: 'Search...',
    prefixIcon: Icon(Icons.search),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  ),
)
```

### Build a Price Display

```dart
Text(
  '\$${product.price.toStringAsFixed(2)}',
  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
)
```

### Build an Empty State

```dart
Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
      SizedBox(height: 16),
      Text('Your cart is empty', style: TextStyle(fontSize: 18)),
    ],
  ),
)
```

---

## 📊 Data Flow Example

### User Adds Product to Cart

1. **User clicks "Add to Cart" on ProductCard**
   ```dart
   onAddToCart: () {
     widget.onAddToCart(product);
   }
   ```

2. **Callback calls _addToCart() in main.dart**
   ```dart
   void _addToCart(Product product) {
     setState(() {
       cartItems.add(product);
     });
   }
   ```

3. **setState triggers rebuild**
   - Cart count updates in app bar
   - All widgets rebuild with new state
   - Visual feedback shown to user

4. **User navigates to cart**
   ```dart
   Navigator.pushNamed(context, '/cart');
   ```

5. **CartScreen receives updated cartItems list and displays them**

---

## 🐛 Debugging Tips

### Check State Updates

Add print statements in state management methods:

```dart
void _addToCart(Product product) {
  setState(() {
    cartItems.add(product);
    print('Cart items: ${cartItems.length}');
  });
}
```

### View Navigation Stack

```dart
print('Current route: ${ModalRoute.of(context)?.settings.name}');
```

### Verify Product Data

```dart
print('Product: ${product.toJson()}');
```

### Check Build Counts

```dart
@override
Widget build(BuildContext context) {
  print('DiscoverScreen rebuilt');
  return ...;
}
```

---

## 📱 Testing Checklist

- [ ] Search functionality works (filters by title and category)
- [ ] Product cards display correctly with images
- [ ] Clicking product navigates to detail screen with correct data
- [ ] Add to cart button updates cart count badge
- [ ] Cart screen shows items correctly
- [ ] Remove button deletes items from cart
- [ ] Empty cart shows proper empty state
- [ ] Price calculations are correct (subtotal, discount, total)
- [ ] Checkout dialog appears and functions
- [ ] Back navigation works from all screens
- [ ] Images load/fail gracefully
- [ ] No null reference errors
- [ ] App works on portrait and landscape orientations

---

## 🚀 Deployment

### Build APK for Android

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### Build App Bundle

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

### Build iOS App

```bash
flutter build ios --release
```

---

## 📞 Getting Help

### Common Issues

**"cartItems not updating"**
- Make sure to call `setState()`, not just modify the list
- Check that callbacks are properly passed to child widgets

**"Navigation not working"**
- Verify route name matches exactly (case-sensitive)
- Ensure route is defined in `onGenerateRoute()`
- Check that `Navigator.pushNamed()` is called with correct context

**"Images not loading"**
- Check image URL is correct
- Ensure internet connectivity
- ProductCard has built-in error handling

**"Build errors"**
- Run `flutter analyze lib/` to check for issues
- Run `flutter pub get` to update dependencies
- Run `flutter clean` before rebuilding

---

## 📚 Code Style Guide

### Naming Conventions

- `Classes`: PascalCase (e.g., `ProductCard`, `DiscoverScreen`)
- `Methods/Variables`: camelCase (e.g., `addToCart`, `cartItems`)
- `Constants`: camelCase with underscore prefix (e.g., `_maxPrice`)
- `File names`: snake_case (e.g., `product_card.dart`)

### Comments

```dart
/// Documentation comment (appears in IDE hover)
// Single line comment
/* Multi-line
   comment */
```

### Code Formatting

Run formatter before committing:

```bash
dart format lib/
```

---

## 🎓 Learning Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Material Design Guidelines](https://material.io/design)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter State Management](https://flutter.dev/docs/development/data-and-backend/state-mgmt)

---

**Version:** 1.0.0  
**Last Updated:** 2024  
**Status:** Production Ready ✅
