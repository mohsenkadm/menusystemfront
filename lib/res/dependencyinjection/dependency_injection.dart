
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';

class dependencyinjection {
 
  static void onInit(){
     Get.put(ProductsController(), permanent: true);
   }
}