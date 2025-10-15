class SpecialOfferEntity {
  final List<String> images;
  final String discount;
  final String description;
  final String id;
  final String title;

  SpecialOfferEntity({
    required this.id,
    required this.title,
    required this.images,
    required this.discount,
    required this.description,
  });
}
