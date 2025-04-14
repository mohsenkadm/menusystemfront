import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:menusystemfront/models/products/product_cart_model.dart';
 
class ListItemCard extends GetxService {
  static List<ProductCartModel> itemscard = [];
  static final GetStorage storage = GetStorage();

  // Add a method to add items to the list
  static void addItem(ProductCartModel product) {
    product.count = 1; // Initialize count to 1 when adding a new item
    itemscard.add(product);
    _saveToStorage();
  }

  // Add a method to remove items from the list
  static void removeItem(int productId) {
    itemscard = getItems();
    final product = itemscard.firstWhere((item) => item.productsId == productId);
    
    itemscard.remove(product);
    _saveToStorage();
  }

  // Add a method to retrieve the list
  static List<ProductCartModel> getItems() {
    final storedData = storage.read<List<dynamic>>('itemscard');
    if (storedData != null) {
      itemscard = storedData.map((e) => ProductCartModel.fromJson(e)).toList();
    }
    return itemscard;
  }

  // Add a method to update the count of an item
  static void updateItemCount(int productId) {
    itemscard = getItems();
    final index = itemscard.indexWhere((item) => item.productsId == productId);
    if (index != -1) {
      itemscard[index].count=(itemscard[index].count!+1);
      _saveToStorage();
    }
  }

  // Helper method to save the list to GetStorage
  static void _saveToStorage() {
     
      // Save the current list if no existing data
      storage.write('itemscard', itemscard.map((item) => item.toJson()).toList());
    
  }
}