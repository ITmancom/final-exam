class ShoeItem {
  final String name;
  final double price;
  int selectedSize; // Allow size to be mutable
  final String imageUrl; // URL for the shoe image

  ShoeItem({
    required this.name,
    required this.price,
    required this.selectedSize,
    required this.imageUrl,
  });
}
