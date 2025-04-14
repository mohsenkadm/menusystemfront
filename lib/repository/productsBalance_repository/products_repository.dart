
import 'package:menusystemfront/data/network/network_api_services.dart';
import 'package:menusystemfront/res/app_url/app_url.dart';
import 'package:http/http.dart' as http; 

class ProductsRepository {
  final _apiService = NetworkApiServices();
 
  Future<dynamic> getProductApi(var parameter) async {
    var path=AppUrl.getProductApi;
    dynamic response = await _apiService.getApi("$path$parameter");
    return response;
  } 

  Future<dynamic> getCategoryApi() async {
    var path=AppUrl.getCategoryApi;
    dynamic response = await _apiService.getApi(path);
    return response;
  } 
  Future<dynamic> getSubCategoryApi(var parameter) async {
    var path=AppUrl.getSubCategoryApi;
    dynamic response = await _apiService.getApi("$path/$parameter");
    return response;
  } 

  Future<dynamic> getResInfoApi() async {
    var path=AppUrl.getResInfoApi;
    dynamic response = await _apiService.getApi(path);
    return response;
  } 
   
}