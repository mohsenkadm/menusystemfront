
import 'package:flutter/material.dart';
import 'package:menusystemfront/res/colors/app_color.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';

class NameRestourant extends StatelessWidget {
  const NameRestourant({
    super.key,
    required this.isArabic,
    required this.productsController,
  });

  final bool isArabic;
  final ProductsController productsController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              style: const TextStyle(
                fontSize: 40,
                color: AppColor.whiteColor,
                fontWeight: FontWeight.bold,
              ),
              isArabic
                  ? productsController.resInfoModeldata!.value?.restaurantName ?? ""
                  : productsController.resInfoModeldata!.value?.restaurantNameEn ?? "",
            ),
            Text(
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: AppColor.whiteColor,
              ),
              isArabic
                  ? productsController.resInfoModeldata!.value?.details ?? ""
                  : productsController.resInfoModeldata!.value?.detailsEn ?? "",
            ),
          ],
        ),
      ),
    );
  }
}
