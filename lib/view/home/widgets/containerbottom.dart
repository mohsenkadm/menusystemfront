import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menusystemfront/res/assets/image_assets.dart';
import 'package:menusystemfront/res/colors/app_color.dart';
import 'package:menusystemfront/utils/utils.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

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
          color: Color.fromARGB(230, 48, 48, 48),

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
                          // Open Facebook
                          final facebookUrl =
                              productsController
                                  .resInfoModeldata!
                                  .value
                                  ?.face ??
                              "";
                          if (facebookUrl.isNotEmpty) {
                            launchUrl(Uri.parse(facebookUrl));
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
                            launchUrl(Uri.parse(instagramUrl));
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
                      GestureDetector(
                        onTap: () {
                          // Open WhatsApp
                          final whatsappUrl =
                              productsController
                                  .resInfoModeldata!
                                  .value
                                  ?.whatsapp ??
                              "";
                          if (whatsappUrl.isNotEmpty) {
                            launchUrl(Uri.parse(whatsappUrl));
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
                          imageUrl: ImageAssets.whatsapp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                onTap: () async {
                      final long =
                          productsController.resInfoModeldata!.value?.long ??
                          "";
                      final lat =
                          productsController.resInfoModeldata!.value?.lat ?? "";

                      if (lat.isNotEmpty && long.isNotEmpty) {
                        final url =
                            'https://www.google.com/maps/search/?api=1&query=$lat,$long';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          throw 'Could not launch $url';
                        }
                      }
                    },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.fitHeight,
                      width: 30,
                      height: 25,
                      placeholder:
                          (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                      errorWidget:
                          (context, url, error) => const Icon(Icons.error),
                      imageUrl: ImageAssets.map,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColor.whiteColor,
                      ),
                      isArabic
                          ? productsController.resInfoModeldata!.value?.address ??
                              ""
                          : productsController
                                  .resInfoModeldata!
                                  .value
                                  ?.addressEn ??
                              "",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                     onTap: () {
                          // Open phone dialer
                          final phone =
                              productsController
                                  .resInfoModeldata!
                                  .value
                                  ?.phone1 ??
                              "";
                          if (phone.isNotEmpty) {
                            launchUrl(Uri.parse("tel:$phone"));
                          }
                        },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.fitHeight,
                          width: 30,
                          height: 25,
                          placeholder:
                              (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          errorWidget:
                              (context, url, error) => const Icon(Icons.error),
                          imageUrl: ImageAssets.call,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColor.whiteColor,
                          ),
                          productsController.resInfoModeldata!.value?.phone1 ??
                              "",
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    '|',
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
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
                              (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          errorWidget:
                              (context, url, error) => const Icon(Icons.error),
                          imageUrl: ImageAssets.wifi,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColor.whiteColor,
                        ),
                        productsController.resInfoModeldata!.value?.wifi ?? "",
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            CachedNetworkImage(
              fit: BoxFit.fitHeight,
              height: 25,
              placeholder:
                  (context, url) =>
                      const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageUrl: ImageAssets.codeq,
            ),
          ],
        ),
      ),
    );
  }
}
