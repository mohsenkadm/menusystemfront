import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menusystemfront/models/products/subCatecory_model.dart';
import 'package:menusystemfront/res/routes/routes_name.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';

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
             subcategoryModel.image ?? "",
           ),
           fit: BoxFit.cover,
         ),
       ),
       child: Center(
         child: Container(
           decoration: BoxDecoration(
               boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 15,
                        offset: const Offset(0, 3),
                      )
                   ]

           ),
           child: Text(
             style: const TextStyle(
               fontSize: 20,
               fontWeight: FontWeight.bold,
               wordSpacing: 2,
               color: Colors.white,
             ),
             isArabic
                 ? subcategoryModel.subCategoryName.toString()
                 : subcategoryModel.subCategoryNameEn.toString(),
           ),
         ),
       ),
              ),
    );
  }
}
