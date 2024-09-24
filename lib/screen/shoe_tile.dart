import 'package:flutter/cupertino.dart';
import 'shoe_item.dart';

class ShoeTile extends StatefulWidget {
  final ShoeItem shoe;
  final Function(ShoeItem) onAddToCart;

  const ShoeTile({super.key, required this.shoe, required this.onAddToCart});

  @override
  // ignore: library_private_types_in_public_api
  _ShoeTileState createState() => _ShoeTileState();
}

class _ShoeTileState extends State<ShoeTile> {
  int selectedSize = 20; // Default to size 20
  List<int> sizes = List.generate(26, (index) => index + 20); // Sizes from 20 to 45

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey5,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Shoe image placeholder or actual image
            Container(
              height: 180, // Increased height for shoe image
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: widget.shoe.imageUrl.isNotEmpty
                  ? Image.network(
                      widget.shoe.imageUrl,
                      fit: BoxFit.cover,
                    )
                  : Center(
                      child: Text(
                        widget.shoe.name,
                        style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                          fontSize: 12, // Smaller font size for the name
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 4), // Space between image and price
            // Shoe Price
            Text(
              '\$${widget.shoe.price.toStringAsFixed(2)}',
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14, // Adjust font size for the price
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8), // Space between price and size picker
            // Size Picker
            CupertinoButton(
              child: Text('Select Size: $selectedSize'),
              onPressed: () {
                _showSizePicker();
              },
            ),
            const SizedBox(height: 8), // Space before the button
            // Add to Cart button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity, // Keeps the button full width
                child: CupertinoButton.filled(
                  child: const Text('Add to Cart'),
                  onPressed: () {
                    widget.shoe.selectedSize = selectedSize;
                    widget.onAddToCart(widget.shoe);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSizePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: CupertinoColors.systemBackground,
          child: Column(
            children: [
              SizedBox(
                height: 180,
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedSize - 20,
                  ),
                  itemExtent: 40.0,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      selectedSize = sizes[index];
                    });
                  },
                  children: sizes.map((size) {
                    return Center(
                      child: Text(size.toString()),
                    );
                  }).toList(),
                ),
              ),
              CupertinoButton(
                child: const Text('Done'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
