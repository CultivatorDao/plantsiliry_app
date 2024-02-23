class ProductModel {

  final String name;
  final String frontImage;
  final String? description;
  final List<String>? images;
  final double? originalPrice;
  final bool? hasDiscount;
  final double? discountPrice;
  final dynamic comments;


  ProductModel({
    required this.name,
    required this.frontImage,
    this.description,
    this.images,
    this.discountPrice,
    this.originalPrice,
    this.hasDiscount,
    this.comments,
  });

}