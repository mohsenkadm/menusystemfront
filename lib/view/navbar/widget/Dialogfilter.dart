
  import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menusystemfront/res/assets/image_assets.dart';
import 'package:menusystemfront/res/colors/app_color.dart';
import 'package:menusystemfront/view_model/controller/products/product_view_model.dart';

Future<dynamic> Dialogfilter(bool isArabic, String pricename,String timeName) {
    final  productsController =
        Get.find<ProductsController>();
    return showDialog(
            context: Get.context!,
            builder: (context) {
             return StatefulBuilder(
                builder: (context, setState) {
                  return Obx(
                    ()=> Dialog(
                      backgroundColor: AppColor.blackColor,
                    
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.whiteColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          children: [
                            // Close button
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: AppColor.whiteColor,
                                ),
                                onPressed: () {
                                  Navigator.of(
                                    context,
                                  ).pop(); // Close the dialog
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColor.whiteColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          isArabic
                                              ? "اختر السعر"
                                              : "Select Price Range",
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
                                                child:
                                                    CircularProgressIndicator(),
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "10,000 $pricename",
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "15,000 $pricename",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: AppColor.whiteColor,
                                        ),
                                      ),
                                       Text(
                                        "20,000 $pricename",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: AppColor.whiteColor,
                                        ),
                                      ),
                                       Text(
                                        "25,000 $pricename",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: AppColor.whiteColor,
                                        ),
                                      ),
                                      
                                      Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Text(
                                          "30,000 $pricename",
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Scrollable slider
                                  Slider(
                                    activeColor: Colors.yellow,
                                    value: productsController.selectedPrice.value,
                                    min: 10000,
                                    max: 30000,
                                    divisions:
                                        4, // Divisions for 10000, 15000, 20000, etc.
                                    label: productsController.selectedPrice.value.toInt().toString(),
                                    onChanged: (value) { 
                                        productsController.selectedPrice.value =
                                            value; 
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                                Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColor.whiteColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          isArabic
                                              ? "وقت الطهي"
                                              : "Cook date",
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
                                                child:
                                                    CircularProgressIndicator(),
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "5 $timeName",
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "10 $timeName",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: AppColor.whiteColor,
                                        ),
                                      ),
                                      Text(
                                        "15 $timeName",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: AppColor.whiteColor,
                                        ),
                                      ),
                                      Text(
                                        "20 $timeName",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: AppColor.whiteColor,
                                        ),
                                      ),
                    
                                      Text(
                                        "25 $timeName",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: AppColor.whiteColor,
                                        ),
                                      ),
                                      Text(
                                        "30 $timeName",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: AppColor.whiteColor,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Text(
                                          "35 $timeName",
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Scrollable slider
                                  Slider(
                                    activeColor: Colors.red,
                                    value: productsController.selectedMintie.value, 
                                    min: 5,
                                    max: 35,
                                    divisions:
                                        7, // Divisions for 10000, 15000, 20000, etc.
                                    label: productsController.selectedMintie.toInt().toString(),
                                    onChanged: (value) { 
                                        productsController.selectedMintie.value =
                                            value; 
                                    },
                                  ),
                                ],
                              ),
                            ),
                        
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
