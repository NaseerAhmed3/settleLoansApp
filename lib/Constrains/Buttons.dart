import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:settle_loans/Constrains/textstyles.dart';

class RoundedButton1 extends StatelessWidget {
  final String text;
  final Function onPressed;

  const RoundedButton1(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFFFFDC60),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.50, color: Color(0xFF488AD2)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {
        // Call the provided onPressed function
        onPressed();
      },
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFF232323),
          fontSize: 16,
          fontFamily: GoogleFonts.rubik().fontFamily,
          fontWeight: FontWeight.w500,
          height: 1.60,
        ),
      ),
    );
  }
}

class ButtonWithIcon extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Widget leading;
  final Widget action;
  final bool centerTitle;
  final double radius;
  final double borderWidth;
  final Color borderColor;
  final Color color;
  final Color textColor;
  final double padding;
  final double fontSize;

  const ButtonWithIcon(
      {super.key,
      required this.text,
      required this.onPressed,
      this.action = const SizedBox(),
      this.leading = const SizedBox(),
      this.centerTitle = false,
      this.radius = 10,
      this.color = const Color(0xFF4285F4),
      this.borderColor = const Color(0xFFBEBEBE),
      this.borderWidth = 1,
      this.textColor = Colors.white,
      this.padding = 0.0,
      this.fontSize = 16});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: borderWidth, color: borderColor),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      onPressed: () {
        // Call the provided onPressed function
        onPressed();
      },
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          mainAxisAlignment: centerTitle
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: [
            leading,
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontFamily: GoogleFonts.rubik().fontFamily,
                fontWeight: FontWeight.w400,
                height: 1.40,
              ),
            ),
            action
          ],
        ),
      ),
    );
  }
}

class Containerbutton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const Containerbutton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(

      child: Container(
        height: 100,
      width:MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration( border: Border.all(),),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 20,
            // decoration: BoxDecoration(image: DecorationImage(image: AssetImage('Vector.png'))),
            ),
      Column(
        children: [
          Text("Card",style: HeadingTextStyle2(),),
          Text("Visa, Mastercard, RuPay",style: ParaTextStyle1(),
          )
          ],
          )
          ],
          ),
      
      ),
    );
  }
}