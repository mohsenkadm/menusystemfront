class CategoryModel {
  int? categoryId;
  String? categoryName;
  String? categoryNameEn;
  String? image;

  CategoryModel(
      {this.categoryId,
      this.categoryName,
      this.categoryNameEn,
      this.image});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    image = json['image'];
    categoryNameEn = json['categoryNameEn'];
  } 
}