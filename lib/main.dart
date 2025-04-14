import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // Import GetStorage
import 'dart:html' as html; // Import html package for web URL access
import 'package:menusystemfront/res/colors/app_color.dart';
import 'package:menusystemfront/res/dependencyinjection/dependency_injection.dart';
import 'package:menusystemfront/res/getx_loclization/languages.dart';
import 'package:menusystemfront/res/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Initialize GetStorage
  dependencyinjection.onInit();
  
  Get.updateLocale(const Locale('ar')); // Switch to Arabic
            
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
      return GetMaterialApp(
        title: '',
        debugShowCheckedModeBanner: false,
        translations: Languages(),
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColor.primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
            labelStyle: const TextStyle(
              color: AppColor.primaryColor, // Set your desired label color here
            ),
            hintStyle: const TextStyle(color: Colors.grey),
            alignLabelWithHint: true,
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColor.primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          fontFamily: "Cairo",
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
              titleLarge:
                  TextStyle(color: AppColor.primaryTextColor, fontSize: 18),
              bodyMedium:
                  TextStyle(color: AppColor.primaryTextColor, fontSize: 14),
              bodySmall: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal)),
        ),
        getPages: AppRoutes.appRoutes(),
      );
    
  }
}
