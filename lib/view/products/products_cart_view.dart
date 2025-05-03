import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:menusystemfront/data/response/status.dart';
import 'package:menusystemfront/models/products/product_cart_model.dart';
import 'package:menusystemfront/models/products/product_model.dart';
import 'package:menusystemfront/res/assets/image_assets.dart';
import 'package:menusystemfront/res/assets/lottie_assets.dart';
import 'package:menusystemfront/res/colors/app_color.dart';
import 'package:menusystemfront/view/home/widgets/NameRestourant.dart';
import 'package:menusystemfront/view/home/widgets/containerbottom.dart';
import 'package:menusystemfront/view/navbar/widget/Dialogfilter.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';
import 'package:menusystemfront/repository/productsBalance_repository/ListItemCard.dart';
import 'package:intl/intl.dart'; // Add this import for number formatting

class ProductsCartView extends StatefulWidget {
  const ProductsCartView({Key? key}) : super(key: key);

  @override
  State<ProductsCartView> createState() => _ProductsCartState();
}

class _ProductsCartState extends State<ProductsCartView> {
  final ProductsController productsController = Get.find<ProductsController>();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    await productsController.getResInfoApitApi();
    productsController.getListItemCard();
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = Get.locale?.languageCode == 'ar';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(isArabic),
      body: Obx(() {
        final status = productsController.rxRequestStatus.value;
        final backgroundImage =
            productsController.resInfoModeldata?.value?.background;

        return Stack(
          children: [
            // Background Image
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
                  // Product List
                  productsController.listItemCard_List.length > 0
                      ? _buildProductSection(status, isArabic)
                      : SizedBox(
                        height: 200,
                        child: Center(
                          child: Lottie.asset(
                            LottieAssets.nofounddata,
                            width: 200,
                            height: 200,
                          ),
                        ),
                      ),
                  // Bottom Container
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

  Widget _buildProductSection(Status status, bool isArabic) {
    final pricename =
        isArabic ? 'دينار' : 'IQD'; // Set price name based on language
    final timeName =
        isArabic ? 'دقيقة' : 'Min'; // Set time name based on language

    List<dynamic> products =
        productsController.listItemCard_List.value; // Updated reference
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 100),
        NameRestourant(
          isArabic: isArabic,
          productsController: productsController,
        ),

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
                return Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.whiteColor, width: 1),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Row(
                    children: [
                      // Left: Product Image
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius:
                              isArabic
                                  ? BorderRadius.only(
                                    topRight: Radius.circular(35),
                                    bottomRight: Radius.circular(35),
                                  )
                                  : BorderRadius.only(
                                    topLeft: Radius.circular(35),
                                    bottomLeft: Radius.circular(35),
                                  ),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              product.image ?? "",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Right: Product Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            // Product Name
                            Text(
                              isArabic
                                  ? product.name.toString()
                                  : product.nameEn.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColor.whiteColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Price Container
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: Text(
                                    '${NumberFormat("#,##0", "ar").format(product.price)} $pricename',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 50),
                                // Time Container
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: Text(
                                    '${product.timeProduct} $timeName',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 50),

                              ],
                            ),

                            Column(
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.whiteColor,
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.2,
                                            ),
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          productsController.removeFromCart(
                                            product,
                                          );
                                           productsController.getListItemCard();
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: AppColor.redColor,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    // Product Count
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.whiteColor,
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.2,
                                            ),
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        '${product.count}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.blackColor,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.whiteColor,
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.2,
                                            ),
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                        
                                          productsController.addToCart(
                                            product,
                                          );
                                          productsController.getListItemCard();
                                           },
                                        icon: const Icon(
                                          Icons.add,
                                          color: AppColor.blackColor,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        const SizedBox(height: 100),
        Container(
          height: 50,
          width: 300,
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
            color: AppColor.whiteColor,
          ),
          child: Center(
            child: Text(
              isArabic
                  ? productsController.listItemCard_List.value.isNotEmpty
                      ? 'السعر الكلي ${NumberFormat("#,##0", "ar").format(productsController.listItemCard_List.value.map((item) => item.price! * item.count!).reduce((ele1, ele2) => ele1 + ele2))} دينار'
                      : 'السعر الكلي 0 دينار'
                  : productsController.listItemCard_List.value.isNotEmpty
                  ? 'total price ${NumberFormat("#,##0", "en").format(productsController.listItemCard_List.value.map((item) => item.price! * item.count!).reduce((ele1, ele2) => ele1 + ele2))} IQD'
                  : 'total price 0 IQD',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                wordSpacing: 2,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }

  AppBar _buildAppBar(bool isArabic) {
    final pricename = isArabic ? 'دينار' : 'IQD';
    final timeName = isArabic ? 'دقيقة' : 'Min';

    return AppBar(
      backgroundColor: Colors.transparent,
      actions: [ 
         IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.home,
            color: AppColor.whiteColor,
            size: 30,
          ),
        ),
        IconButton(
          onPressed: () {

                  AwesomeDialog(
                          buttonsBorderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          context: context,
                          dialogType: DialogType.warning,
                          headerAnimationLoop: true,
                          animType: AnimType.bottomSlide,
                          title: 'حذف السلة',
                          reverseBtnOrder: true,
                          showCloseIcon: true,
                          btnOkText: 'نعم',
                          btnCancelText: 'الغاء',
                          btnOkIcon: Icons.check_circle,
                          btnCancelIcon: Icons.cancel,
                          btnOkOnPress: () {
                            
              productsController.clearCart();
            productsController.getListItemCard();
                          },
                          btnCancelOnPress: () {},
                          desc: 'هل تريد حذف السلة حقا؟')
                      .show();
          },
          icon: const Icon(
            Icons.remove_shopping_cart,
            color: AppColor.whiteColor,
            size: 30,
          ),
        ),
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
            placeholder:
                (context, url) =>
                    const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageUrl: ImageAssets.imagetranslate,
          ),
        ),
        const SizedBox(width: 20),
      ],
      leading: Obx(
        () =>
            productsController.resInfoModeldata?.value == null
                ? const SizedBox()
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
                              .toString(),
                    ),
                  ),
                ),
      ),
      elevation: 0,
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
