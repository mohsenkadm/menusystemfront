import 'package:flutter/material.dart';
import 'package:menusystemfront/res/colors/app_color.dart';

class customButton extends StatelessWidget {
  const customButton(
      {Key? key,
      required this.onPress,
      this.loading = false,
      required this.title,
      required this.iconbutton})
      : super(key: key);

  final bool loading;
  final String title;
  final VoidCallback onPress;
  final IconData? iconbutton;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 45,
      child: ElevatedButton.icon(
          onPressed: onPress,
          icon:iconbutton!=null? Icon(
            iconbutton,
            color: Colors.white,
          ):null,
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColor.primaryColor),
          label: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: loading
                ? const Center(child: const CircularProgressIndicator())
                : Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          )),
    );
  }
}
