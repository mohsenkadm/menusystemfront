import 'package:get_storage/get_storage.dart';

class AppUrl {
  //static String nameRes = GetStorage().read('nameRes')??''; // Default value
  
  static const String baseUrl = 'https://codeqserver-001-site1.qtempurl.com/Avoca';///$nameRes';
 
  static  const String getProductApi='$baseUrl/Products/GetApp/';

  static  const String getCategoryApi='$baseUrl/Category/GetApp';

  static  const String getSubCategoryApi='$baseUrl/SubCategory/GetByCategoryId';

  static  const String getResInfoApi='$baseUrl/Restaurant/GetProfile';
}