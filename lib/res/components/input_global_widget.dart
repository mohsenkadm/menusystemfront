import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:menusystemfront/res/colors/app_color.dart';

 
class InputglobalWidget extends StatelessWidget {
  const InputglobalWidget(
      {super.key,
      required this.text,
      required this.iconData,
      required this.textEditingController,
      this.isnumber = false,
      this.isvalidation = true
      });
  final String text;
  final IconData? iconData;
  final Rx<TextEditingController> textEditingController;
  final bool isnumber;
  final bool isvalidation;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style:  TextStyle(
              fontSize: iconData==null?12:14,
              color: AppColor.blackColor,
            ),
      keyboardType: isnumber
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      inputFormatters: isnumber
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            ]
          : null,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        prefixIcon:iconData==null? null: Icon(
          iconData,
          color: AppColor.primaryColor,
        ),
        border: const OutlineInputBorder(),
        labelText: text,
        hintText: 'اكتب $text',
      ),
      controller: textEditingController.value,
      validator: (value) {
        if (value!.isEmpty && isvalidation) {
         return 'اكتب $text رجاءا';
        }
        return null;
      },
    );
  }
}
