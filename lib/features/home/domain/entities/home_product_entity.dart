class HomeProductEntity {
  final int id;
  final String name;
  final String imageUrl;
  final double price;
  final double rate;
  final int sold;
  final bool isFavorite;

  const HomeProductEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rate,
    required this.sold,
    required this.isFavorite,
  });
}
