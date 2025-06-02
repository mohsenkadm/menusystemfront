import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menusystemfront/models/products/product_cart_model.dart';
import 'package:menusystemfront/models/products/product_model.dart';
import 'package:menusystemfront/res/colors/app_color.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';
import 'package:show_network_image/show_network_image.dart';

import '../../../repository/productsBalance_repository/ListItemCard.dart';

Future<dynamic> DiloagTwo(
  ProductsController productsController,
  bool isArabic,
  ProductsModel prodModel,
  String pricename,
  String timeName,
) {
  return showDialog(
    context: Get.context!,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          void updateDialog() => setState(() {});
          return Dialog(
            backgroundColor: AppColor.blackColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.whiteColor, width: 0.5),
                borderRadius: BorderRadius.circular(25),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 220,
                      child: Stack(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
                              child: ShowNetworkImage(
                                imageSrc: prodModel.image ?? "",
                                mobileBoxFit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(child:
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(padding: EdgeInsets.all(10),
                            child: IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: Icon(Icons.cancel, color: Colors.white,))),
                          ))
                        ],
                      ),
                    ),
                    isArabic
                        ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                isArabic
                                    ? prodModel.name ?? ""
                                    : prodModel.nameEn ?? "",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Spacer(),
                              priceTag(
                                '${prodModel.price?.toStringAsFixed(0) ?? "0"} $pricename',
                              ),
                            ],
                          ),
                        )
                        : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                isArabic
                                    ? prodModel.name ?? ""
                                    : prodModel.nameEn ?? "",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Spacer(),
                              priceTag(
                                '${prodModel.price?.toStringAsFixed(0) ?? "0"} $pricename',
                              ),
                            ],
                          ),
                        ),

                    isArabic
                        ?
                        // Description
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              isArabic
                                  ? prodModel.details ?? ""
                                  : prodModel.detailsEn ?? "",
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColor.whiteColor,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        : Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 25,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              isArabic
                                  ? prodModel.details ?? ""
                                  : prodModel.detailsEn ?? "",
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColor.whiteColor,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),

                    const SizedBox(height: 10),

                    // Counter buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildIconButton(
                          icon: Icons.remove,
                          onTap: () {
                            var productCartModel =
                                ProductCartModel.fromProductModel(prodModel);
                            productsController.removeFromCart(productCartModel);
                            updateDialog();
                          },
                        ),
                        const SizedBox(width: 20),
                        buildIconButton(
                          icon: Icons.add,
                          onTap: () {
                            var productCartModel =
                                ProductCartModel.fromProductModel(prodModel);
                            productsController.addToCart(productCartModel);
                            updateDialog();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

// Helper to style the tags (price/time)
Widget priceTag(String text) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 3,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColor.blackColor,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

// Helper for button UI
Widget buildIconButton({required IconData icon, required VoidCallback onTap}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: IconButton(
      onPressed: onTap,
      icon: Icon(icon, color: AppColor.blackColor, size: 30),
    ),
  );
}
