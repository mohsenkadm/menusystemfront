import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:menusystemfront/models/products/product_cart_model.dart';

class ListItemCard {
  static final GetStorage _storage = GetStorage();
  static List<ProductCartModel> _items = [];

  // Initialize storage
  static Future<void> init() async {
    await _storage.initStorage;
    _loadItems();
  }

  // Private method to load items
  static void _loadItems() {
    try {
      final storedData = _storage.read<List<dynamic>>('itemscard');
      if (storedData != null) {
        _items = storedData.map((e) => ProductCartModel.fromJson(e)).toList();
      }
    } catch (e) {
      Get.log('Error loading cart items: $e');
      _items = [];
    }
  }

  // Private method to save items
  static void _saveItems() {
    try {
      _storage.write('itemscard', _items.map((item) => item.toJson()).toList());
    } catch (e) {
      Get.log('Error saving cart items: $e');
    }
  }

  // Public methods
  static List<ProductCartModel> getItems() => List.from(_items);

  static void addItem(ProductCartModel product) {
    final index = _items.indexWhere((item) => item.productsId == product.productsId);

    if (index != -1) {
      _items[index].count = (_items[index].count ?? 0) + 1;
    } else {
      _items.add(ProductCartModel(
        productsId: product.productsId,
        name: product.name,
        nameEn: product.nameEn,
        details: product.details,
        detailsEn: product.detailsEn,
        image: product.image,
        price: product.price,
        timeProduct: product.timeProduct,
        count: 1,
      ));
    }
    _saveItems();
  }

  static void removeItem(int productId) {
    final index = _items.indexWhere((item) => item.productsId == productId);
    if (index != -1) {
      if (_items[index].count! > 1) {
        _items[index].count = _items[index].count! - 1;
      } else {
        _items.removeAt(index);
      }
      _saveItems();
    }
  }

  static void updateItemCount(int productId) {
    final index = _items.indexWhere((item) => item.productsId == productId);
    if (index != -1) {
      _items[index].count = (_items[index].count ?? 0) + 1;
      _saveItems();
    }
  }

  static void clearCart() {
    _items.clear();
    _storage.remove('itemscard');
  }
}