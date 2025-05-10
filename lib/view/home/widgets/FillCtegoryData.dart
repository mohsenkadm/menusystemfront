import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:menusystemfront/models/products/category_model.dart';
import 'package:menusystemfront/res/colors/app_color.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';
import 'package:show_network_image/show_network_image.dart';

class FillCategoryData extends StatefulWidget {
  const FillCategoryData({
    super.key,
    required this.categoryModel,
    required this.isArabic,
    required this.isUsedSubCategory,
    required this.productsController,
    required this.isfromProducts,
  });

  final List<dynamic>? categoryModel;
  final bool isArabic;
  final bool isUsedSubCategory;
  final ProductsController productsController;
  final bool isfromProducts;
  @override
  State<FillCategoryData> createState() => _FillCategoryDataState();
}

class _FillCategoryDataState extends State<FillCategoryData> {
  int _selectedIndex = 1; // Start from the second category (index 1)
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: _selectedIndex,
      viewportFraction: 0.4,
    );

    _pageController.addListener(() {
      if (mounted) setState(() {});
    });

    // Load data for the second category initially
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.productsController.category_List.length > 1) {
        final categoryId =
            widget.productsController.category_List[1].categoryId ?? 0;

        if (widget.isfromProducts == true) {
          widget.productsController.getproductsApi(categoryId: categoryId);
        } else {
          if (widget.isUsedSubCategory) {
            widget.productsController.getSubCategoryApi(categoryid: categoryId);
          } else {
            widget.productsController.getproductsApi(categoryId: categoryId);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.productsController.category_List.isEmpty) {
      return const SizedBox(child: Center(child: CircularProgressIndicator()));
    }

    return SizedBox(
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.productsController.category_List.length,
        onPageChanged: (index) {
          if (index >= 0 &&
              index < widget.productsController.category_List.length) {
            setState(() => _selectedIndex = index);
            final categoryModel =
                widget.productsController.category_List.value[index];
            final categoryId = categoryModel.categoryId ?? 0;

            if (widget.isfromProducts == true) {
              widget.productsController.getproductsApi(categoryId: categoryId);
            } else {
              if (widget.isUsedSubCategory) {
                widget.productsController.getSubCategoryApi(
                  categoryid: categoryId,
                );
              } else {
                widget.productsController.getproductsApi(
                  categoryId: categoryId,
                );
              }
            }
          }
        },
        itemBuilder: (context, index) {
          if (index < 0 ||
              index >= widget.productsController.category_List.length) {
            return const SizedBox();
          }

          final categoryModel = widget.productsController.category_List[index];
          final pageOffset = index - (_pageController.page ?? index.toDouble());
          final isCentered = pageOffset.abs() < 0.5;

          return InkWell(
            onTap: () {
              if (index >= 0 &&
                  index < widget.productsController.category_List.length) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Transform.scale(
              scale: isCentered ? 1.0 : 0.8,
              child: Opacity(
                opacity: isCentered ? 1.0 : 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: isCentered ? 80 : 60,
                      height: isCentered ? 80 : 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: ShowNetworkImage(
                          imageSrc: categoryModel.image?.toString() ?? '',
                          mobileBoxFit: BoxFit.cover,
                        ),

                        //                        CachedNetworkImage(
                         //                         fit: BoxFit.cover,
                        //                         placeholder: (context, url) => const Center(
                        //                           child: CircularProgressIndicator(),
                        //                         ),
                        //                         errorWidget: (context, url, error) => const Icon(Icons.broken_image),
                        //                         imageUrl: categoryModel.image?.toString() ?? '',
                        //                       ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        widget.isArabic
                            ? categoryModel.categoryName?.toString() ??
                                'No Name'
                            : categoryModel.categoryNameEn?.toString() ??
                                'No Name',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
