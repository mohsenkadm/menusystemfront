import 'package:flutter/material.dart';
import 'package:menusystemfront/res/assets/image_assets.dart';
import 'package:menusystemfront/view_model/services/SplashServices.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashScreen = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(); 
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(child:
      Padding(
        padding: const EdgeInsets.all(25),
        child: null//Image.asset(ImageAssets.logolong),
      )),
    );
  }
}