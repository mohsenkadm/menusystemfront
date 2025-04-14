
import 'package:flutter/material.dart';
import 'package:menusystemfront/res/colors/app_color.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key, required this.onpress, required this.title,
    required this.isactive, required this.iconData,
    required this.isPostLocation
  });
 final VoidCallback onpress;
 final String title;
 final bool isactive;
 final IconData iconData;
 final bool isPostLocation;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onpress,
        style: OutlinedButton.styleFrom(
          padding:const EdgeInsets.symmetric(horizontal: 10),
          foregroundColor:isPostLocation==false ? Colors.grey : isactive?AppColor.whiteColor:AppColor.primaryColor,
          backgroundColor:isPostLocation==false ? AppColor.whiteColor :  isactive? AppColor.primaryColor :AppColor.whiteColor,
          side: const BorderSide(
              width: 1, color: AppColor.primaryColor),
        ),
        child:  Row(
          children: [
             Icon(iconData,color:isactive? AppColor.whiteColor:AppColor.primaryColor,),
            const SizedBox(
              width: 5,
            ),
            Text(title)
          ],
        ));
  }
}