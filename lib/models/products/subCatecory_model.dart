class SubCategoryModel {
  int? subCategoryId;
  String? subCategoryName;
  String? subCategoryNameEn;
  String? image;

  SubCategoryModel(
      {this.subCategoryId,
      this.subCategoryName,
      this.subCategoryNameEn,
      this.image});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    subCategoryId = json['subCategoryId'];
    subCategoryName = json['subCategoryName'];
    subCategoryNameEn=json['subCategoryNameEn'];
    image=json['image'];
  }
 
}