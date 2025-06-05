import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menusystemfront/res/assets/image_assets.dart';
import 'package:menusystemfront/res/colors/app_color.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';

Future<dynamic> Dialogfilter(bool isArabic, String pricename, String timeName) {
  final productsController = Get.find<ProductsController>();
  return showDialog(
    context: Get.context!,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Obx(
            () => Dialog(
              backgroundColor: AppColor.blackColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,  
                height: MediaQuery.of(context).size.height * 0.4,  
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.whiteColor, width: 1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: AppColor.whiteColor,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Price Range Section
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.whiteColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [ 
                                Text(
                                  isArabic
                                      ? "اختر السعر"
                                      : "Select Price Range",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.whiteColor, 
                                  )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    isArabic ? "اختر السعر" : "Select Price Range",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.whiteColor,
                                    ), 
                                  ),
                                ),
                                const SizedBox(width: 10),
                                CachedNetworkImage(
                                  fit: BoxFit.fitHeight,
                                  width: 50,
                                  height: 30,
                                  placeholder:
                                      (context, url) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                  errorWidget:
                                      (context, url, error) =>
                                          const Icon(Icons.error),
                                  imageUrl: ImageAssets.imagedollar,
                                ),
                        ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Row(
                                children: [
                                  for (var price in [
                                    10000,
                                    15000,
                                    20000,
                                    25000,
                                    70000,
                                  ])
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Text(
                                        "${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} IQD",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: AppColor.whiteColor,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Slider(
                            activeColor: Colors.yellow,
                            value: productsController.selectedPrice.value,
                            min: 10000,
                            max: 70000,
                            divisions:
                                4, // Changed from 5 to 4 because you have 5 values (which means 4 intervals)
                            label: productsController.selectedPrice.value
                                .toInt()
                                .toString()
                                .replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},',
                                ),
                            onChanged: (value) {
                              productsController.selectedPrice.value = value;
                              productsController.getProductsBySubCategoryApi(
                                productsController
                                        .selectedSubCategoryId
                                        .value ??
                                    0,
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    // Time Section 
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.whiteColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  isArabic ? "وقت الطهي" : "Cook date",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                CachedNetworkImage(
                                  fit: BoxFit.fitHeight,
                                  width: 50,
                                  height: 30,
                                  placeholder:
                                      (context, url) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                  errorWidget:
                                      (context, url, error) =>
                                          const Icon(Icons.error),
                                  imageUrl: ImageAssets.imagecoke,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Row(
                                children: [
                                  for (var time in [
                                    "5",
                                    "10",
                                    "25",
                                    "35",
                                    "50",
                                    "70",
                                    "95",
                                  ])
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Text(
                                        "$time $timeName",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: AppColor.whiteColor,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Slider(
                            activeColor: Colors.red,
                            value: productsController.selectedMintie.value,
                            min: 5,
                            max: 95,
                            divisions: 6, // Steps: 5, 20, 35, 50, 65, 80, 95
                            label:
                                productsController.selectedMintie.value
                                    .toInt()
                                    .toString(), // Show raw value
                            onChanged: (value) {
                              productsController.selectedMintie.value = value;
                              productsController.getProductsBySubCategoryApi(
                                productsController
                                        .selectedSubCategoryId
                                        .value ??
                                    0,
                              );
                            },
                          ),
                        ],
                      ),
                    ), 
                    // Container(
                    //   margin: const EdgeInsets.all(10),
                    //   decoration: BoxDecoration(
                    //     border: Border.all(
                    //       color: AppColor.whiteColor,
                    //       width: 1,
                    //     ),
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 10, left: 10),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               isArabic ? "وقت الطهي" : "Cook date",
                    //               style: const TextStyle(
                    //                 fontSize: 20,
                    //                 fontWeight: FontWeight.bold,
                    //                 color: AppColor.whiteColor,
                    //               ),
                    //             ),
                    //             const SizedBox(width: 10),
                    //             CachedNetworkImage(
                    //               fit: BoxFit.fitHeight,
                    //               width: 50,
                    //               height: 30,
                    //               placeholder: (context, url) =>
                    //               const Center(child: CircularProgressIndicator()),
                    //               errorWidget: (context, url, error) => const Icon(Icons.error),
                    //               imageUrl: ImageAssets.imagecoke,
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       const SizedBox(height: 20),
                    //       // SingleChildScrollView(
                    //       //   scrollDirection: Axis.horizontal,
                    //       //   child: Padding(
                    //       //     padding: const EdgeInsets.symmetric(horizontal: 10),
                    //       //     child: Row(
                    //       //       children: [
                    //       //         for (var time in ["5", "10", "15", "20", "25", "30", "35"])
                    //       //           Padding(
                    //       //             padding: const EdgeInsets.symmetric(horizontal: 8),
                    //       //             child: Text(
                    //       //               "$time $timeName",
                    //       //               style: const TextStyle(
                    //       //                 fontSize: 10,
                    //       //                 color: AppColor.whiteColor,
                    //       //               ),
                    //       //             ),
                    //       //           ),
                    //       //       ],
                    //       //     ),
                    //       //   ),
                    //       // ),
                    //       Slider(
                    //         activeColor: Colors.red,
                    //         value: productsController.selectedMintie.value,
                    //         min: 5,
                    //         max: 35,
                    //         divisions: 6,
                    //         label: productsController.selectedMintie.value.toInt().toString(),
                    //         onChanged: (value) {
                    //           productsController.selectedMintie.value = value;
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ), 
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
