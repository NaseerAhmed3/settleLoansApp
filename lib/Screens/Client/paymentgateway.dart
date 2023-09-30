import 'package:flutter/material.dart';
import 'package:settle_loans/Constrains/Buttons.dart';
import 'package:settle_loans/Constrains/textstyles.dart';

class pamentGatewa extends StatefulWidget {
  const pamentGatewa({super.key});

  @override
  State<pamentGatewa> createState() => _pamentGatewaState();
}

class _pamentGatewaState extends State<pamentGatewa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settleloans",style: HeadingTextStyle1()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          children: [
            Text("Cards, UPI & More",style: HeadingTextStyle1(),),
            SizedBox(height: 20,),
            Containerbutton(text: "hhh", onPressed: (){}),
            Containerbutton(text: "hhh", onPressed: (){}),
            Containerbutton(text: "hhh", onPressed: (){}),
          ],
        ),
      ),
    );
  }
}