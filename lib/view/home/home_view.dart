import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:menusystemfront/data/response/status.dart';
import 'package:menusystemfront/models/products/subCatecory_model.dart';
import 'package:menusystemfront/res/colors/app_color.dart';
import 'package:menusystemfront/res/components/general_exception.dart';
import 'package:menusystemfront/res/components/internet_exceptions_widget.dart';
import 'package:menusystemfront/view/home/widgets/FillCtegoryData.dart';
import 'package:menusystemfront/view/home/widgets/FillSubCategoryData.dart';
import 'package:menusystemfront/view/home/widgets/NameRestourant.dart';
import 'package:menusystemfront/view/home/widgets/containerbottom.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';

class homeview extends StatefulWidget {
  final ScrollController scrollController;
  const homeview({Key? key, required this.scrollController}) : super(key: key);

  @override
  State<homeview> createState() => _homepageState();
}

class _homepageState extends State<homeview> {
  final productsController = Get.find<ProductsController>();

  @override
  void initState() {
    super.initState();
    productsController.getSubCategoryApi();
    productsController.getCategoryApi();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isArabic = Get.locale?.languageCode == 'ar';

    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      onRefresh: () => productsController.refreshApi(),
      child: SingleChildScrollView(
        controller: widget.scrollController,
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
                  onPress: () => productsController.refreshApi(),
                );
              } else {
                return GeneralExceptionWidget(
                  onPress: () => productsController.refreshApi(),
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
                  SizedBox(
                    height: 180,
                    width: screenWidth,
                    child: FillCategoryData(
                      productsController: productsController,
                      categoryModel: productsController.category_List.value,
                      isArabic: isArabic,
                      isUsedSubCategory: productsController
                          .resInfoModeldata
                          ?.value
                          ?.isUsedSubCategory ??
                          false,
                      isfromProducts: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: productsController.subCategory_List.length,
                      itemBuilder: (context, index) {
                        SubCategoryModel subcategoryModel =
                        productsController.subCategory_List.value[index];
                        return FillSubCategoryData(
                          subcategoryModel: subcategoryModel,
                          productsController: productsController,
                          isArabic: isArabic,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 100),
                  containerbottom(
                    screenWidth: screenWidth,
                    isArabic: isArabic,
                    productsController: productsController,
                  ),
                ],
              );
          }
        }),
      ),
    );
  }
}
