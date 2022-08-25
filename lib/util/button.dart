import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final icon;
  final String number;

  MyButton({this.icon, this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: [
          Icon(
            icon,
            size: 25,
          ),
          SizedBox(
            height: 2,
          ),
          Text(number),
        ],
      ),
    );
  }
}
