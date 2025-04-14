import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menusystemfront/res/colors/app_color.dart';

class appbarglobal extends StatelessWidget implements PreferredSizeWidget {
  const appbarglobal({
    super.key,
    required this.title, this.widgets,
  });
  final String title;
  final List<Widget>? widgets;
  @override
  Widget build(BuildContext context) {
    // ignore: duplicate_ignore
    return AppBar(
      actions: widgets,
        leading: IconButton(
            onPressed: ()=> Get.back(),
            icon:  const Icon(Icons.arrow_back_ios, color: AppColor.whiteColor)),
        elevation: 5,
        shadowColor: AppColor.blackColor,
        surfaceTintColor: AppColor.primaryColor,
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: Text(title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: AppColor.whiteColor)));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
