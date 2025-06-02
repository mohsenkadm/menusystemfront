import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:menusystemfront/models/products/product_model.dart';
import 'package:menusystemfront/res/colors/app_color.dart';
import 'package:menusystemfront/view/products/widgets/DialogProduct.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';
import 'package:show_network_image/show_network_image.dart';

import 'DialogTwo.dart';

class ProductTwo extends StatelessWidget {
  const ProductTwo({
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
        DiloagTwo(productsController, isArabic, prodModel, pricename, timeName);
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffe6e6e6),
            ),
            child: Column(
              children: [
                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    child: Center(
                      child: ShowNetworkImage(
                        imageSrc: prodModel.image ?? "",
                        mobileBoxFit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                isArabic
                    ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Text(
                              isArabic
                                  ? prodModel.name.toString()
                                  : prodModel.nameEn.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // Spacer(),
                          Container(
                            height: 25,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                '${NumberFormat("#,##0", "ar").format(prodModel.price)} $pricename',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    : Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Text(
                              isArabic
                                  ? prodModel.name.toString()
                                  : prodModel.nameEn.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // Spacer(),
                          Container(
                            height: 25,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                '${NumberFormat("#,##0", "ar").format(prodModel.price)} $pricename',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            left: 20,
            child: GestureDetector(
              onTap: () {
                DiloagTwo(
                  productsController,
                  isArabic,
                  prodModel,
                  pricename,
                  timeName,
                );
              },
              child: Container(color : Colors.black.withOpacity(0.001),height: 120, width: 200),
            ),
          ),
        ],
      ),
    );
  }
}
