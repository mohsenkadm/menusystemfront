class ResInfoModel {
 int? restaurantId;
  String? routeName;
  String? restaurantName;
  String? restaurantNameEn;
  String? details;
  String? detailsEn;
  String? userName;
  String? password;
  String? phone1;
  String? phone2;
  String? long;
  String? lat;
  String? address;
  String? addressEn;
  bool? isActive;
  bool? isDelete;
  bool? isUsedSubCategory;
  String? dateInsert;
  String? logo;
  String? background;
  String? wifi;
  String?whatsapp;
  String? insta;
  String? face;

  ResInfoModel(
      {this.restaurantId,
      this.routeName,
      this.restaurantName,
      this.restaurantNameEn,
      this.details,
      this.detailsEn,
      this.userName,
      this.password,
      this.phone1,
      this.phone2,
      this.long,
      this.lat,
      this.address,
      this.addressEn,
      this.isActive,
      this.isDelete,
      this.isUsedSubCategory,
      this.dateInsert,
      this.logo,
      this.background,
      this.wifi,
      this.face,
      this.insta,
      this.whatsapp});

  ResInfoModel.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurantId'];
    routeName = json['routeName'];
    restaurantName = json['restaurantName'];
    restaurantNameEn = json['restaurantNameEn'];
    details = json['details'];
    detailsEn = json['detailsEn'];
    userName = json['userName'];
    password = json['password'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    long = json['long'];
    lat = json['lat'];
    address = json['address'];
    addressEn = json['addressEn'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    isUsedSubCategory = json['isUsedSubCategory'];
    dateInsert = json['dateInsert'];
    logo = json['logo'];
    background = json['background'];
    whatsapp=json['whatsapp'];
    wifi=json['wifi'];
    face=json['face'];
    insta=json['insta'];
  } 
}