import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menusystemfront/models/products/subCatecory_model.dart';
import 'package:menusystemfront/res/routes/routes_name.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';
import 'package:show_network_image/show_network_image.dart';

class FillSubCategoryData extends StatelessWidget {
  const FillSubCategoryData({
    super.key,
    required this.productsController,
    required this.isArabic,
    required this.subcategoryModel,
  });

  final ProductsController productsController;
  final bool isArabic;
  final SubCategoryModel subcategoryModel;
@override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(
        RouteName.productsView,
        arguments: {'subCategoryId': subcategoryModel.subCategoryId},
      );
    },
    child: Container(
      height: 220,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
      child: Stack(
        children: [
          // Image background using ShowNetworkImage
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: ShowNetworkImage(
              imageSrc: subcategoryModel.image ?? "",
              mobileBoxFit: BoxFit.cover,
            ),
          ),
          // Text overlay
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Text(
                isArabic
                    ? subcategoryModel.subCategoryName.toString()
                    : subcategoryModel.subCategoryNameEn.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 2,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}
