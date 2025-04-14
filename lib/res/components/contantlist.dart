import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class contantlist { 
  String url;
  String title;
  IconData icon;
  contantlist({required this.url,required this.title,required this.icon});
}

List<contantlist> contantlistitem = [
  contantlist(
     url: "",
     title: "أ. محمد فيصل",icon: Icons.facebook
  ), 

  contantlist(
     url: "",
     title: "أ. محمد فيصل",icon: Icons.public
  ), 
  contantlist(
     url: ""
     ,title: "أ. محمد فرحان",icon: Icons.facebook
  ), 

  contantlist(
     url: ""
     ,title: "أ. محمد فرحان",icon: Icons.public
  ),  
];