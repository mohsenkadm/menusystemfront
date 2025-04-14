import 'package:get/get.dart';
import 'package:menusystemfront/data/response/status.dart';
import 'package:menusystemfront/models/products/category_model.dart';
import 'package:menusystemfront/models/products/product_cart_model.dart';
import 'package:menusystemfront/models/products/product_model.dart';
import 'package:menusystemfront/models/products/restourant_model.dart';
import 'package:menusystemfront/models/products/subCatecory_model.dart';
import 'package:menusystemfront/repository/productsBalance_repository/ListItemCard.dart';
import 'package:menusystemfront/repository/productsBalance_repository/products_repository.dart';

class ProductsController extends GetxController {
  final _api = ProductsRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final productsCatlog_List = [].obs;
  final category_List = [].obs;
  final subCategory_List = [].obs;
  final listItemCard_List = [].obs;
  Rxn<ResInfoModel>? resInfoModeldata = Rxn<ResInfoModel>();

  RxDouble selectedPrice = 30000.0.obs;
  RxDouble selectedMintie = 20.0.obs;
  RxString error = ''.obs;

  var isLoadMore = false.obs;

  @override
  void dispose() {
    productsCatlog_List.value.clear();
    super.dispose();
  }

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setproductsList(var _value) =>
      productsCatlog_List.value =
          _value['data'].map((json) => ProductsModel.fromJson(json)).toList();
  void setCategoryList(var _value) =>
      category_List.value =
          _value['data'].map((json) => CategoryModel.fromJson(json)).toList();

  void setSubCategoryList(var _value) =>
      subCategory_List.value =
          _value['data']
              .map((json) => SubCategoryModel.fromJson(json))
              .toList();

  void setResInfoList(var _value) =>
      resInfoModeldata?.value = ResInfoModel.fromJson(_value['data']);

  void setError(String _value) => error.value = _value;

  Future<void> getproductsApi({ 
    int categoryId = 0,
  }) async { 
    int subCategoryId = 0;
    subCategoryId=Get.arguments==null?0: Get.arguments['subCategoryId'] ?? 0;
    String parameter = "$categoryId,$subCategoryId,%20,1000,${selectedPrice.value},3,${selectedMintie.value}";
    await _api
        .getProductApi(parameter)
        .then((value) {
          setRxRequestStatus(Status.COMPLETED);
          setproductsList(value);
        })
        .onError((error, stackTrace) {
          setError(error.toString());
          setRxRequestStatus(Status.ERROR);
        });
  }

  Future<void> getCategoryApi() async {
    await _api
        .getCategoryApi()
        .then((value) {
          setRxRequestStatus(Status.COMPLETED);
          setCategoryList(value);
          if (resInfoModeldata?.value != null) {
            if (resInfoModeldata?.value?.isUsedSubCategory == true) {
              int categoryid = category_List[0].categoryId;
              getSubCategoryApi(categoryid: categoryid);
            }
          }
        })
        .onError((error, stackTrace) {
          setError(error.toString());
          setRxRequestStatus(Status.ERROR);
        });
  }

  Future<void> getSubCategoryApi({int categoryid = 0}) async {
    await _api
        .getSubCategoryApi(categoryid)
        .then((value) {
          setRxRequestStatus(Status.COMPLETED);
          setSubCategoryList(value);
        })
        .onError((error, stackTrace) {
          setError(error.toString());
          setRxRequestStatus(Status.ERROR);
        });
  }

  Future<void> getResInfoApitApi() async {
    await _api
        .getResInfoApi()
        .then((value) {
          setRxRequestStatus(Status.COMPLETED);
          setResInfoList(value);
        })
        .onError((error, stackTrace) {
          setError(error.toString());
          setRxRequestStatus(Status.ERROR);
        });
  }

  Future<void> refreshApi() async {
    setRxRequestStatus(Status.LOADING);
    await getproductsApi();
  }

  void addToCart(ProductCartModel product) {
    // Check if the product already exists in the cart
    bool exists = ListItemCard.getItems().any((item) => item.productsId == product.productsId);
    
    if (exists) {
     ListItemCard.updateItemCount(product.productsId);
        // Assuming 'count' is a property of ProductsModel
    } else {
       ProductCartModel productCartModel = ProductCartModel(
        productsId: product.productsId,
        name: product.name,
        nameEn: product.nameEn,
        details: product.details,
        detailsEn: product.detailsEn,
        image: product.image,
        price: product.price,
        timeProduct: product.timeProduct, // Add timeProduct here
        count: 1, // Initialize count to 1 when adding a new item
      );
       ListItemCard.addItem(productCartModel);
    }
  }
  
  void getListItemCard() {
    if (ListItemCard.getItems().isNotEmpty) {
      listItemCard_List.value = ListItemCard.getItems();
    } else {
      listItemCard_List.value = [];
    }
  }

  void removeFromCart(ProductCartModel product) {

    // Check if the product exists in the cart
    bool exists = ListItemCard.getItems().any((item) => item.productsId == product.productsId);
    if (!exists) {
      return; // Product not found in the cart, no action needed
    }
     ListItemCard.removeItem(product.productsId); 
  }

  void clearCart() {
    if (ListItemCard.getItems().isNotEmpty) {
      listItemCard_List.value = [];
      ListItemCard.itemscard.clear();
      ListItemCard.storage.remove('itemscard');
    } 
  }
}
