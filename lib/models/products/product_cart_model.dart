class ProductCartModel {
    int productsId;
    String name;
    String? nameEn;
    String? details;
    String? detailsEn;
    String? image; 
    double price;
    int? count;
    int? timeProduct; // Restore the timeProduct field
  
  ProductCartModel({
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
  factory ProductCartModel.fromJson(Map<String, dynamic> json) {
    return ProductCartModel(
      productsId: json['productsId'],
      name: json['name'],
      nameEn: json['nameEn'],
      details: json['details'], 
      detailsEn: json['detailsEn'],
      image: json['image'],
      price: json['price'], 
      count: json['count'],
      timeProduct: json['timeProduct'] ,
    );
  }

   
}