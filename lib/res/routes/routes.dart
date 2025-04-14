

import 'package:get/get.dart';
import 'package:menusystemfront/res/routes/routes_name.dart';
import 'package:menusystemfront/view/navbar/nav_bar.dart';
import 'package:menusystemfront/view/products/products_cart_view.dart';
import 'package:menusystemfront/view/products/products_view.dart';
import 'package:menusystemfront/view/splash_screen.dart';
class AppRoutes {

  static appRoutes() => [
    GetPage(
      name: RouteName.splashScreen,
      page: () => const SplashScreen() ,
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade ,
    )
,
GetPage(
      name: RouteName.navbar,
      page: () => const navbar() ,
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade ,
    )
, 
GetPage(
      name: RouteName.productscartView,
      page: () => const ProductsCartView() ,
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade ,
    )
, 
    GetPage(
      name: RouteName.productsView,
      page: () => const ProductsView() ,
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade ,
    )
    ];
}