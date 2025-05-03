import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menusystemfront/res/assets/image_assets.dart';
import 'package:menusystemfront/res/colors/app_color.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';

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
                  // for social media
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // // Open Facebook
                          // final facebookUrl = productsController
                          //         .resInfoModeldata!
                          //         .value
                          //         ?.facebookUrl ??
                          //     "";
                          // if (facebookUrl.isNotEmpty) {
                          //   Utils.launchURL(facebookUrl);
                          // }
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
                          // // Open Instagram
                          // final instagramUrl = productsController
                          //         .resInfoModeldata!
                          //         .value
                          //         ?.instagramUrl ??
                          //     "";
                          // if (instagramUrl.isNotEmpty) {
                          //   Utils.launchURL(instagramUrl);
                          // }
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
                      GestureDetector(
                        onTap: () {
                          // // Open WhatsApp
                          // final whatsappUrl = productsController
                          //         .resInfoModeldata!
                          //         .value
                          //         ?.whatsappUrl ??
                          //     "";
                          // if (whatsappUrl.isNotEmpty) {
                          //   Utils.launchURL(whatsappUrl);
                          // }
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
                          imageUrl: ImageAssets.whatsapp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // final mapUrl = productsController.resInfoModeldata!.value?.mapUrl ?? "";
                    // if (mapUrl.isNotEmpty) {
                    //   Utils.launchURL(mapUrl);
                    // }
                  },
                  child: CachedNetworkImage(
                    fit: BoxFit.fitHeight,
                    width: 30,
                    height: 25,
                    placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    imageUrl: ImageAssets.map,
                  ),
                ),
                const SizedBox(width: 5),
                // 🟢 Wrap the text in Expanded to allow wrapping
                Expanded(
                  child: Text(
                    isArabic
                        ? productsController.resInfoModeldata!.value?.address ?? ""
                        : productsController.resInfoModeldata!.value?.addressEn ?? "",
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColor.whiteColor,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),

            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    // Open WiFi settings or related action
                    // Utils.snackBar("WiFi action not implemented");
                  },
                  child: CachedNetworkImage(
                    fit: BoxFit.fitHeight,
                    width: 30,
                    height: 25,
                    placeholder:
                        (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                    imageUrl: ImageAssets.call,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColor.whiteColor,
                  ),
                  productsController.resInfoModeldata!.value?.phone1 ?? "",
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
