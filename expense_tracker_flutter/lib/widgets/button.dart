import 'package:flutter/material.dart';

class CButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double fontSize;
  final double width;
  final double height;
  final double borderRadius;

  const CButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue, // Default button color
    this.textColor = Colors.white, // Default text color
    this.fontSize = 16.0, // Default font size
    this.width = 200.0, // Default width
    this.height = 50.0, // Default height
    this.borderRadius = 8.0, // Default border radius
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor, // Text color
            fontSize: fontSize, // Text size
          ),
        ),
      ),
    );
  }
}
