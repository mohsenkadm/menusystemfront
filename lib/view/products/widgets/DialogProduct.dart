import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menusystemfront/models/products/product_cart_model.dart';
import 'package:menusystemfront/models/products/product_model.dart';
import 'package:menusystemfront/res/assets/image_assets.dart';
import 'package:menusystemfront/res/colors/app_color.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';

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
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.whiteColor, width: 2),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  // Close button
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: AppColor.whiteColor),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ),
                  const SizedBox(height: 10),

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
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                prodModel.image ?? "",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                wordSpacing: 2,
                                color: Colors.white,
                              ),
                              isArabic
                                  ? prodModel.name.toString()
                                  : prodModel.nameEn.toString(),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 45,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColor.blackColor,
                              ),
                              '${prodModel.price!.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} $pricename',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 45,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.blackColor,
                              ),
                              '${prodModel.timeProduct} $timeName',
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
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.whiteColor,
                        ),
                        isArabic
                            ? '${prodModel.details}التفاصيل'
                            : 'Description ${prodModel.detailsEn}',
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ), 
                  // Add to cart button
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                        child: IconButton(onPressed: (){ 
                            ProductCartModel productCartModel = ProductCartModel(
                              productsId: prodModel.productsId,
                              name: prodModel.name,
                              nameEn: prodModel.nameEn,
                              details: prodModel.details,
                              detailsEn: prodModel.detailsEn,
                              image: prodModel.image,
                              price: prodModel.price,
                              timeProduct: prodModel.timeProduct, 
                            );
                            productsController.removeFromCart(productCartModel); 
                        }, icon: Icon(Icons.delete,
                         color: AppColor.blackColor, size: 30,)),
                      ), 
                      const SizedBox(width: 10),
                      const SizedBox(width: 10),
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
                        child: IconButton(onPressed: (){
                          ProductCartModel productCartModel = ProductCartModel(
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
                        }, icon: Icon(Icons.add,
                         color: AppColor.blackColor, size: 30,)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
