import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:menusystemfront/models/products/product_model.dart';
import 'package:menusystemfront/res/colors/app_color.dart';
import 'package:menusystemfront/view/products/widgets/DialogProduct.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';
import 'package:show_network_image/show_network_image.dart';

class FillProductData extends StatelessWidget {
  const FillProductData({
    super.key,
    required this.productsController,
    required this.isArabic,
    required this.prodModel,
  });

  final ProductsController productsController;
  final bool isArabic;
  final ProductsModel prodModel;
@override
Widget build(BuildContext context) {
  final pricename = isArabic ? 'دينار' : 'IQD';
  final timeName = isArabic ? 'دقيقة' : 'Min';

  return GestureDetector(
    onTap: () {
      DialogProduct(productsController, isArabic, prodModel, pricename, timeName);
    },
    child: SizedBox(
      height: 230,
      child: Stack(
        children: [
          // Main Image Container
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: ShowNetworkImage(
                imageSrc: prodModel.image ?? "",
                mobileBoxFit: BoxFit.cover,
               ),
            ),
          ),
          
          // Product Name Text
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  isArabic ? prodModel.name.toString() : prodModel.nameEn.toString(),
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
                '${NumberFormat("#,##0", "ar").format(prodModel.price)} $pricename',
                style: const TextStyle(
                  fontSize: 16,
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
  );
}}
