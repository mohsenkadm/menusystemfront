import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:menusystemfront/models/products/product_model.dart';
import 'package:menusystemfront/models/products/subCatecory_model.dart';
import 'package:menusystemfront/res/colors/app_color.dart';
import 'package:menusystemfront/res/routes/routes_name.dart';
import 'package:menusystemfront/view/products/widgets/DialogProduct.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';

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
    final pricename =
        isArabic ? 'دينار' : 'IQD'; // Set price name based on language
    final timeName =
        isArabic ? 'دقيقة' : 'Min'; // Set time name based on language

    return InkWell(
      onTap: () {
        DialogProduct(productsController,isArabic, prodModel,pricename, timeName );
      },
      child: SizedBox(
        height: 230,
        child: Stack(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
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
                  image: CachedNetworkImageProvider(prodModel.image ?? ""),
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
                  '${NumberFormat("#,##0", "ar").format(prodModel.price)} $pricename',
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
    );
  }
}
