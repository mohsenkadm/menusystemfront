import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:menusystemfront/data/response/status.dart';
import 'package:menusystemfront/res/assets/image_assets.dart';
import 'package:menusystemfront/res/assets/lottie_assets.dart';
import 'package:menusystemfront/res/colors/app_color.dart';
import 'package:menusystemfront/res/components/general_exception.dart';
import 'package:menusystemfront/res/components/internet_exceptions_widget.dart';
import 'package:menusystemfront/res/routes/routes_name.dart';
import 'package:menusystemfront/view/home/widgets/FillCtegoryData.dart';
import 'package:menusystemfront/view/home/widgets/FillProductData.dart';
import 'package:menusystemfront/view/home/widgets/containerbottom.dart';
import 'package:menusystemfront/view/navbar/widget/Dialogfilter.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsCatalogState();
}

class _ProductsCatalogState extends State<ProductsView> {
  final ProductsController productsController = Get.find<ProductsController>();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    await productsController.getResInfoApitApi();
    await productsController.getCategoryApi();
    await productsController.getproductsApi();
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = Get.locale?.languageCode == 'ar';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(isArabic),
      body: Obx(() {
        final status = productsController.rxRequestStatus.value;
        final backgroundImage = productsController.resInfoModeldata?.value?.background;
        final products = productsController.productsCatlog_List.value;

        return Stack(
          children: [
            if (backgroundImage != null && backgroundImage.isNotEmpty)
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(backgroundImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

            // Overlay
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.7),
            ),

            // Main Content
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 100,),
                  _buildProductSection(status, isArabic, products),
                  SizedBox(height: 40,),
                  containerbottom(
                    screenWidth: MediaQuery.of(context).size.width,
                    isArabic: isArabic,
                    productsController: productsController,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildCategorySection(Status status, bool isArabic) {
    if (status != Status.COMPLETED) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: SizedBox(
        height: 180,
        width: MediaQuery.of(context).size.width,
        child: FillCategoryData(
          productsController: productsController,
          categoryModel: productsController.category_List.value,
          isArabic: isArabic,
          isUsedSubCategory: productsController
                  .resInfoModeldata?.value?.isUsedSubCategory ??
              false,
          isfromProducts: true,
        ),
      ),
    );
  }

  Widget _buildProductSection(Status status, bool isArabic, List<dynamic> products) {
    switch (status) {
      case Status.LOADING:
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: AppColor.whiteColor,
              size: 50,
            ),
          ),
        );
      case Status.ERROR:
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: productsController.error.value == 'No internet'
              ? InterNetExceptionWidget(
                  onPress: () async => await productsController.refreshApi(),
                )
              : GeneralExceptionWidget(
                  onPress: () async => await productsController.refreshApi(),
                ),
        );
      case Status.COMPLETED:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            products.isEmpty
                ? SizedBox(
                    height: 200,
                    child: Center(
                      child: Lottie.asset(
                        LottieAssets.nofounddata,
                        width: 200,
                        height: 200,
                      ),
                    ),
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(5),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return FillProductData(
                        productsController: productsController,
                        isArabic: isArabic,
                        prodModel: product,
                      );
                    },
                  ),
          ],
        );
      default:
        return const SizedBox(
          height: 200,
          child: Center(child: Text('Unknown status')),
        );
    }
  }

  AppBar _buildAppBar(bool isArabic) {
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
            placeholder:
                (context, url) =>
                    const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageUrl: ImageAssets.shoppingcard,
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () => Dialogfilter(isArabic, pricename, timeName),
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
      leading: Obx(() => productsController.resInfoModeldata?.value == null
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageUrl: productsController.resInfoModeldata!.value!.logo.toString(),
                ),
              ),
            )),
      elevation: 0,
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}