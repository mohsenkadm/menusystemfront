
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import 'package:menusystemfront/res/assets/image_assets.dart';
import 'package:menusystemfront/res/colors/app_color.dart';
import 'package:menusystemfront/res/routes/routes_name.dart';
import 'package:menusystemfront/view/home/home_view.dart';
import 'package:menusystemfront/view/navbar/widget/Dialogfilter.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';

class navbar extends StatefulWidget {
  const navbar({Key? key}) : super(key: key);

  @override
  _navbarState createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  final productsController = Get.find<ProductsController>();
  final ScrollController _scrollController =
      ScrollController();

  @override
  void initState() {
     
    productsController.getResInfoApitApi();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose the ScrollController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            child: FloatingActionButton(
              backgroundColor: AppColor.whiteColor,
              onPressed: () {
                _scrollController.animateTo(0,
                  duration: const Duration(milliseconds: 500,),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(Icons.keyboard_arrow_up),
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        appBar: my_app_bar(),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    productsController.resInfoModeldata?.value?.background ??
                        "",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.8), // 10% black overlay
            ),
            homeview(
              scrollController: _scrollController,
            ),
          ],
        ),
      ),
    );
  }

  AppBar my_app_bar() {
    final isArabic =
        Get.locale?.languageCode == 'ar';
    final pricename =
        isArabic ? 'دينار' : 'IQD';
    final timeName =
        isArabic ? 'دقيقة' : 'Min';

    return AppBar(
      backgroundColor: Colors.transparent, // Makes AppBar transparent
      actions: [
        GestureDetector(
          onTap: () {
            // Toggle between Arabic and English
            final currentLocale = Get.locale?.languageCode;
            if (currentLocale == 'ar') {
              Get.updateLocale(const Locale('en')); // Switch to English
            } else {
              Get.updateLocale(const Locale('ar')); // Switch to Arabic
            }
          },
          child: CachedNetworkImage(
            fit: BoxFit.fitHeight,
            width: 50,
            height: 30,
            placeholder:
                (context, url) =>
                    const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageUrl: ImageAssets.imagetranslate,
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteName.productscartView);
          },
          child: CachedNetworkImage(
            fit: BoxFit.fitHeight,
            width: 50,
            height: 25,
            placeholder:
                (context, url) =>
                    const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageUrl: ImageAssets.shoppingcard,
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            // Show dialog with price range
            Dialogfilter(isArabic, pricename, timeName);
          },
          child: CachedNetworkImage(
            fit: BoxFit.fitHeight,
            width: 50,
            height: 25,
            placeholder:
                (context, url) =>
                    const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageUrl: ImageAssets.imageFilter,
          ),
        ),
        const SizedBox(width: 20),
      ],
      leading: Obx(
        () =>
            productsController.resInfoModeldata!.value == null
                ? SizedBox()
                : Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: CachedNetworkImage(
                      fit: BoxFit.fitWidth,
                      placeholder:
                          (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                      errorWidget:
                          (context, url, error) => const Icon(Icons.error),
                      imageUrl:
                          productsController.resInfoModeldata!.value!.logo
                              .toString() ??
                          "",
                    ),
                  ),
                ),
      ),
      elevation: 0,
    );
  }
}
