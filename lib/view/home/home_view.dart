import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:menusystemfront/data/response/status.dart';
import 'package:menusystemfront/models/products/category_model.dart';
import 'package:menusystemfront/models/products/subCatecory_model.dart';
import 'package:menusystemfront/res/assets/image_assets.dart';
import 'package:menusystemfront/res/colors/app_color.dart';
import 'package:menusystemfront/res/components/custom_card.dart';
import 'package:menusystemfront/res/components/general_exception.dart';
import 'package:menusystemfront/res/components/internet_exceptions_widget.dart';
import 'package:menusystemfront/res/routes/routes_name.dart';
import 'package:menusystemfront/utils/utils.dart';
import 'package:menusystemfront/view/home/widgets/FillCtegoryData.dart';
import 'package:menusystemfront/view/home/widgets/FillSubCategoryData.dart';
import 'package:menusystemfront/view/home/widgets/NameRestourant.dart';
import 'package:menusystemfront/view/home/widgets/containerbottom.dart';
import 'package:menusystemfront/view/home/widgets/custom_outlined_button.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';

class homeview extends StatefulWidget {
  final ScrollController scrollController; // Add ScrollController parameter

  const homeview({Key? key, required this.scrollController}) : super(key: key);

  @override
  State<homeview> createState() => _homepageState();
}

// ignore: camel_case_types
class _homepageState extends State<homeview> {
  final box = GetStorage();
  final productsController = Get.find<ProductsController>();

  @override
  void initState() {
    super.initState();
    productsController.getSubCategoryApi(categoryid: 1);
    productsController.getCategoryApi();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final isArabic =
        Get.locale?.languageCode == 'ar'; // Check if the language is Arabic

    return Container(
      color: Colors.transparent,
      child: RefreshIndicator(
        color: Theme.of(context).primaryColor,
        onRefresh: () async {
          await productsController.refreshApi();
        },
        child: SingleChildScrollView(
          controller: widget.scrollController, // Attach ScrollController
          physics: const AlwaysScrollableScrollPhysics(),
          child: Obx(() {
            switch (productsController.rxRequestStatus.value) {
              case Status.LOADING:
                return Center(
                  child: LoadingAnimationWidget.discreteCircle(
                    color: AppColor.whiteColor,
                    size: 50,
                  ),
                ); 
              case Status.ERROR:
                if (productsController.error.value == 'No internet') {
                  return InterNetExceptionWidget(
                    onPress: () async {
                      await productsController.refreshApi();
                    },
                  );
                } else {
                  return GeneralExceptionWidget(
                    onPress: () async {
                      await productsController.refreshApi();
                    },
                  );
                }
              case Status.COMPLETED:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 100),
                    NameRestourant(
                      isArabic: isArabic,
                      productsController: productsController,
                    ),
                    const SizedBox(height: 10),
        
                    // Horizontal ListView for Categories
                    SizedBox(
                      height: 180, // Constrained height for the ListView
                      width: screenWidth, // Use screen width dynamically
                      child: FillCategoryData(
                        productsController: productsController,
                        categoryModel:
                            productsController.category_List.value,
                        isArabic: isArabic,
                        isUsedSubCategory:
                            productsController
                                .resInfoModeldata!
                                .value!
                                .isUsedSubCategory ??
                            false,
                        isfromProducts: false,
                      ),
                    ),
        
                    // Horizontal ListView for Subcategories
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            productsController.subCategory_List.length,
                        itemBuilder: (context, index) {
                          SubCategoryModel subcategoryModel =
                              productsController
                                  .subCategory_List
                                  .value[index];
                          return FillSubCategoryData(
                            subcategoryModel: subcategoryModel,
                            productsController: productsController,
                            isArabic: isArabic,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ), // Add spacing for the bottom container
                    containerbottom(
                          screenWidth: screenWidth,
                          isArabic: isArabic,
                          productsController: productsController,
                        ),
                  ],
                );
              default:
                return const Center(child: Text('Unknown status'));
            }
          }),
        ),
      ),
    );
  }
}
