class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String category;
  final double rating;
  final int reviews;
  final bool isVeg;
  final bool isPopular;
  final List<String> tags;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.rating,
    required this.reviews,
    this.isVeg = false,
    this.isPopular = false,
    this.tags = const [],
  });
}