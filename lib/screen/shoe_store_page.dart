import 'package:flutter/cupertino.dart';
import 'shoe_item.dart';
import 'shoe_tile.dart';

class ShoeStorePage extends StatelessWidget {
  final List<ShoeItem> shoes;
  final ValueChanged<ShoeItem> onAddToCart; // Callback that accepts a ShoeItem

  const ShoeStorePage({super.key, required this.shoes, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Shoe Store'),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            int columns = (constraints.maxWidth ~/ 200).clamp(1, 4);

            return CupertinoScrollbar(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.65,
                ),
                itemCount: shoes.length,
                itemBuilder: (context, index) {
                  return ShoeTile(
                    shoe: shoes[index],
                    onAddToCart: (ShoeItem shoe) => onAddToCart(shoe), // Corrected line
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
