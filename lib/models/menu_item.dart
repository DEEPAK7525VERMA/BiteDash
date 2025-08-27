class MenuItem {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final bool availability;
  final String category;
  final double rating;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.availability,
    required this.category,
    required this.rating,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] ?? '',
      name: json['name'] ?? 'No Name',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      description: json['description'] ?? 'No description available.',
      imageUrl: json['imageUrl'] ?? 'https://placehold.co/200x200',
      availability: json['availability'] ?? false,
      category: json['category'] ?? 'Uncategorized',
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
    );
  }
}