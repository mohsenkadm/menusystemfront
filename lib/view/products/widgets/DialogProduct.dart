import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menusystemfront/models/products/product_cart_model.dart';
import 'package:menusystemfront/models/products/product_model.dart';
import 'package:menusystemfront/res/assets/image_assets.dart';
import 'package:menusystemfront/res/colors/app_color.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';
import 'package:show_network_image/show_network_image.dart';

Future<dynamic> DialogProduct(
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
          return Dialog(
            backgroundColor: AppColor.blackColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.whiteColor, width: 2),
                borderRadius: BorderRadius.circular(25),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: AppColor.whiteColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Product Image with ShowNetworkImage
                    SizedBox(
                      height: 230,
                      child: Stack(
                        children: [
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: ShowNetworkImage(
                                imageSrc: prodModel.image ?? "",
                                mobileBoxFit: BoxFit.cover,
                              ),
                            ),
                          ),

                          // Product Name Overlay
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 15,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  isArabic
                                      ? prodModel.name.toString()
                                      : prodModel.nameEn.toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    wordSpacing: 2,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Price Tag
                          Positioned(
                            bottom: 0,
                            left: 45,
                            child: Container(
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
                                '${prodModel.price!.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} $pricename',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.blackColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                          // Time Tag
                          Positioned(
                            bottom: 0,
                            right: 45,
                            child: Container(
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
                                '${prodModel.timeProduct} $timeName',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.blackColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Description
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          isArabic
                              ? '${prodModel.details}'
                              : '${prodModel.detailsEn}',
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

                    // Add/Remove buttons
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Delete Button
                        Container(
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
                            onPressed: () {
                              ProductCartModel productCartModel =
                                  ProductCartModel(
                                    productsId: prodModel.productsId,
                                    name: prodModel.name,
                                    nameEn: prodModel.nameEn,
                                    details: prodModel.details,
                                    detailsEn: prodModel.detailsEn,
                                    image: prodModel.image,
                                    price: prodModel.price,
                                    timeProduct: prodModel.timeProduct,
                                  );
                              productsController.removeFromCart(
                                productCartModel,
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                              color: AppColor.blackColor,
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Add Button
                        Container(
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
                            onPressed: () {
                              ProductCartModel productCartModel =
                                  ProductCartModel(
                                    productsId: prodModel.productsId,
                                    name: prodModel.name,
                                    nameEn: prodModel.nameEn,
                                    details: prodModel.details,
                                    detailsEn: prodModel.detailsEn,
                                    image: prodModel.image,
                                    price: prodModel.price,
                                    timeProduct: prodModel.timeProduct,
                                  );
                              productsController.addToCart(productCartModel);
                            },
                            icon: Icon(
                              Icons.add,
                              color: AppColor.blackColor,
                              size: 30,
                            ),
                          ),
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
