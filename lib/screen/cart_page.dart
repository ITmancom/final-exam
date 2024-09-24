import 'package:flutter/cupertino.dart';
import 'shoe_item.dart';

class CartPage extends StatelessWidget {
  final List<ShoeItem> cartItems;
  final Function(ShoeItem) onRemoveFromCart; // Callback for removing items

  const CartPage({super.key, required this.cartItems, required this.onRemoveFromCart});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Your Cart'),
      ),
      child: SafeArea(
        child: cartItems.isEmpty
            ? Center(
                child: Text(
                  'Your cart is empty',
                  style: CupertinoTheme.of(context).textTheme.textStyle,
                ),
              )
            : ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final shoe = cartItems[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoListTile(
                      leading: Text(shoe.name),
                      title: Text('\$${shoe.price.toStringAsFixed(2)}'),
                      subtitle: Text('Size: ${shoe.selectedSize}'),
                      trailing: CupertinoButton(
                        child: const Icon(CupertinoIcons.delete),
                        onPressed: () {
                          onRemoveFromCart(shoe); // Call the remove function
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
