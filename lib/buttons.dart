import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;
  MyButtons({this.color,this.buttonText,this.textColor,this.buttonTapped});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(color: textColor,fontSize: 25.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
