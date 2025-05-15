import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menusystemfront/res/assets/image_assets.dart';
import 'package:menusystemfront/res/colors/app_color.dart';
import 'package:menusystemfront/res/routes/routes_name.dart';
import 'package:menusystemfront/view/home/home_view.dart';
import 'package:menusystemfront/view/navbar/widget/Dialogfilter.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';
import 'package:show_network_image/show_network_image.dart';

class navbar extends StatefulWidget {
  const navbar({Key? key}) : super(key: key);

  @override
  _navbarState createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  final productsController = Get.find<ProductsController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    productsController.getResInfoApitApi();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          child: FloatingActionButton(
            backgroundColor: AppColor.whiteColor,
            onPressed: () {
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 500),
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
          // Background image with Obx
          Obx(() {
            final backgroundImage =
                productsController.resInfoModeldata!.value?.background ?? '';
            if (backgroundImage.isEmpty) return const SizedBox();

            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: ShowNetworkImage(
                imageSrc: backgroundImage,
                mobileBoxFit: BoxFit.cover,
              ),
            );
          }),

          // Dark overlay
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.8),
          ),

          // Home content
          homeview(scrollController: _scrollController),
        ],
      ),
    );
  }

  AppBar my_app_bar() {
    final isArabic = Get.locale?.languageCode == 'ar';
    final pricename = isArabic ? 'دينار' : 'IQD';
    final timeName = isArabic ? 'دقيقة' : 'Min';

    return AppBar(
      backgroundColor: Colors.transparent,
      actions: [
        GestureDetector(
          onTap: () {
            final currentLocale = Get.locale?.languageCode;
            if (currentLocale == 'ar') {
              Get.updateLocale(const Locale('en'));
            } else {
              Get.updateLocale(const Locale('ar'));
            }
          },
          child: CachedNetworkImage(
            fit: BoxFit.fitHeight,
            width: 50,
            height: 30,
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
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
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageUrl: ImageAssets.shoppingcard,
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            Dialogfilter(isArabic, pricename, timeName);
          },
          child: CachedNetworkImage(
            fit: BoxFit.fitHeight,
            width: 50,
            height: 25,
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageUrl: ImageAssets.imageFilter,
          ),
        ),
        const SizedBox(width: 20),
      ],
      leading: Obx(() {
        final logo = productsController.resInfoModeldata?.value?.logo ?? '';
        if (logo.isEmpty) return const SizedBox();

        return Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: ShowNetworkImage(
              imageSrc: logo,
              mobileBoxFit: BoxFit.fitWidth,
            ),
          ),
        );
      }),
      elevation: 0,
    );
  }
}
