class ProductsModel {
  final int productsId;
  final String name;
  final String? nameEn;
  final String? details;
  final String? detailsEn;
  final String? image; 
  final double price;
  final int? count;
  final int? timeProduct; // Restore the timeProduct field
  
  ProductsModel({
    required this.productsId,
    required this.name,
    required this.price,
    this.nameEn,
    this.details,
    this.detailsEn,
    this.image,
    this.count=1,
    this.timeProduct, // Add timeProduct to the constructor
  });

  // Convert a ProductsModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'productsId': productsId,
      'name': name,
      'nameEn': nameEn,
      'details': details,
      'detailsEn': detailsEn,
      'image': image,
      'price': price, 
      'count': count,
      'timeProduct': timeProduct, // Serialize timeProduct
    };
  }

  // Create a ProductsModel instance from a JSON map
  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      productsId: json['productsId'],
      name: json['name'],
      nameEn: json['nameEn'],
      details: json['details'], 
      detailsEn: json['detailsEn'],
      image: json['image'],
      price: json['price'], 
      timeProduct: json['timeProduct'] ,
    );
  }

  // Add a copyWith method to update specific fields
  ProductsModel copyWith({
    int? productsId,
    String? name,
    double? price,
    int? count, 
    String? nameEn,
    String? details,
    String? detailsEn,
    String? image,
    int? timeProduct,
  }) {
    return ProductsModel(
      productsId: productsId ?? this.productsId,
      name: name ?? this.name,
      price: price ?? this.price,
      count: count ?? this.count,
      nameEn:nameEn?? this.nameEn,
      details:details?? this.details,
      detailsEn:detailsEn?? this.detailsEn,
      image:image?? this.image,
      timeProduct:timeProduct?? this.timeProduct,

     );
  }
}