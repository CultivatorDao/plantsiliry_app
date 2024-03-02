import 'dart:ffi';

class ProductModel {

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

  final String name;
  final String frontImage;
  final String? description;
  final List? images;
  final double? originalPrice;
  final bool? hasDiscount;
  final double? discountPrice;
  final dynamic comments;

}