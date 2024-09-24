import 'package:flutter/cupertino.dart';
import 'shoe_store_page.dart';
import 'shoe_item.dart';
import 'cart_page.dart';

void main() {
  runApp(const ShoeApp());
}

class ShoeApp extends StatefulWidget {
  const ShoeApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShoeAppState createState() => _ShoeAppState();
}

class _ShoeAppState extends State<ShoeApp> {
  final List<ShoeItem> shoes = [
    ShoeItem(name: 'Nike Air Max', price: 100.0, selectedSize: 7, imageUrl: 'https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/9f684ace-3163-4227-8f85-2d2a067dd4f5/AIR+MAX+90+GTX.png'),
    ShoeItem(name: 'Adidas Superstar', price: 120.0, selectedSize: 7, imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoFI3yv7sdi02eT7ARn7-9j_Dzh_U_JrUr0Q&s'),
    ShoeItem(name: 'Puma RS-X', price: 90.0, selectedSize: 7, imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdi2qLfhGJ7TKsOG3QFcMdLSWn6kg6jobLPA&s'),
    ShoeItem(name: 'Skechers', price: 80.0, selectedSize: 7, imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCnVc-UJ9A2WXY1EotWLuHnLogiNosgQcj0g&s'),
    ShoeItem(name: 'New Balance', price: 110.0, selectedSize: 7, imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYvtuOXqhlJtfz5AfR2AsdVzDmaP_RJPD4ag&s'),
    ShoeItem(name: 'Converse', price: 85.0, selectedSize: 7, imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0jRf_pKFt6JFXj6vgIZSRgwtCSAYKO5b4qw&s'),
    ShoeItem(name: 'Air Jordans', price: 150.0, selectedSize: 7, imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSP3sbI-KFg3Uv14DTGjPRIZIvGxMELx1UEdw&s'),
    ShoeItem(name: 'Gucci Shoes', price: 300.0, selectedSize: 7, imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREaHO_gBpedxmkNi4xlrUwgKvBM_43OIqbEA&s'),
    ShoeItem(name: 'Adidas Football Boots', price: 130.0, selectedSize: 7, imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8fQ-eyVbEKWwmW0aOvQMeQcicPReWIYhVaw&s'),
  ];

  List<ShoeItem> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
      ),
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Store',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.shopping_cart),
              label: 'Cart',
            ),
          ],
        ),
        tabBuilder: (context, index) {
          if (index == 0) {
            // Shoe Store Page
            return ShoeStorePage(
              shoes: shoes,
              onAddToCart: (ShoeItem shoe) {
                setState(() {
                  cartItems.add(shoe);
                });
              },
            );
          } else {
            // Cart Page
            return CartPage(
              cartItems: cartItems,
              onRemoveFromCart: (ShoeItem shoe) {
                setState(() {
                  cartItems.remove(shoe); // Remove the item from the cart
                });
              },
            );
          }
        },
      ),
    );
  }
}
