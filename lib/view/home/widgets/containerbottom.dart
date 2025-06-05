import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menusystemfront/res/assets/image_assets.dart';
import 'package:menusystemfront/res/colors/app_color.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';

import '../../../utils/utils.dart';

class containerbottom extends StatelessWidget {
  const containerbottom({
    super.key,
    required this.screenWidth,
    required this.isArabic,
    required this.productsController,
  });

  final double screenWidth;
  final bool isArabic;
  final ProductsController productsController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 220,
        width: screenWidth,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.95),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    style: const TextStyle(
                      fontSize: 25,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                    isArabic
                        ? productsController
                                .resInfoModeldata!
                                .value
                                ?.restaurantName ??
                            ""
                        : productsController
                                .resInfoModeldata!
                                .value
                                ?.restaurantNameEn ??
                            "",
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Open Facebook
                          final facebookUrl =
                              productsController
                                  .resInfoModeldata!
                                  .value
                                  ?.face ??
                              "";
                          if (facebookUrl.isNotEmpty) {
                            Utils.launchURL(facebookUrl);
                          }
                        },
                        child: CachedNetworkImage(
                          fit: BoxFit.fitHeight,
                          width: 30,
                          height: 25,
                          placeholder:
                              (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          errorWidget:
                              (context, url, error) => const Icon(Icons.error),
                          imageUrl: ImageAssets.face,
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          // Open Instagram
                          final instagramUrl =
                              productsController
                                  .resInfoModeldata!
                                  .value
                                  ?.insta ??
                              "";
                          if (instagramUrl.isNotEmpty) {
                            Utils.launchURL(instagramUrl);
                          }
                        },
                        child: CachedNetworkImage(
                          fit: BoxFit.fitHeight,
                          width: 30,
                          height: 25,
                          placeholder:
                              (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          errorWidget:
                              (context, url, error) => const Icon(Icons.error),
                          imageUrl: ImageAssets.insta,
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    final mapUrl =
                        productsController.resInfoModeldata!.value?.addressEn ??
                        "";
                    if (mapUrl.isNotEmpty) {
                      Utils.launchURL(mapUrl);
                    }
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.location_on, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        isArabic ? "العنوان" : "our location",
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColor.whiteColor,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                Icon(Icons.call, color: Colors.white),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    final whatsApp =
                        productsController.resInfoModeldata!.value?.phone1 ??
                        "";
                    if (whatsApp.isNotEmpty) {
                      Utils.launchURL(whatsApp);
                    }
                  },
                  child: Text(
                    isArabic ? "اتصل بنا" : "Contact Us",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            CachedNetworkImage(height: 20, imageUrl: ImageAssets.codeq),
          ],
        ),
      ),
    );
  }
}
