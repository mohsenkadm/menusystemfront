import 'package:flutter/material.dart';
import 'package:menusystemfront/res/colors/app_color.dart';

class customcard extends StatelessWidget {
  const customcard(
      {super.key,
      required this.texttitle,
      required this.iconbox,
      dynamic onTap,
      required this.isPostLocation})
      : _onTap = onTap;
  final String texttitle;
  final IconData iconbox;
  final VoidCallback _onTap;
  final bool isPostLocation;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: _onTap,
        child: Container(
          height: 130,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isPostLocation == false
                  ? [Colors.grey, Colors.grey]
                  : [AppColor.secondaryColor, AppColor.primaryColor],
            ),
          ),
          margin: const EdgeInsets.fromLTRB(4, 4, 4, 4),
          padding: const EdgeInsets.all(0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(iconbox, size: 40),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      height: 25,
                      width: 25,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_back_ios,
                            size: 20, color: Colors.white.withOpacity(0.7)),
                      ),
                    ),
                    Text(
                      texttitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
