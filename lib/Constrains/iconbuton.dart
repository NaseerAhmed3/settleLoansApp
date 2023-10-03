import 'package:flutter/material.dart';

class KIconButton extends StatelessWidget {
  String title;
  Function onPressed;
  String Img;
   KIconButton({super.key ,required this.title,required this.onPressed, required this.Img});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed(),
      child: Container(
        child: Row(children: [
       
        Container(color: Colors.red, width: 100,height: 100,),
         Text(title),
        ],),
      ),
    );
  }
}