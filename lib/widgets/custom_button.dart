import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final MaterialColor? color;
  final String text;
  final double? fontSize;
  final Function()? onPressed;

  const CustomButton({
    Key? key,
    this.color,
    required this.text,
    this.fontSize,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all(const StadiumBorder()),
        elevation: MaterialStateProperty.all(5),
      ),
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(text, style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
