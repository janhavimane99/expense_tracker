import 'package:flutter/material.dart';

class CText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final TextDecoration decoration;
  final String fontFamily;
  final bool border;
  final bool borderSide;

  const CText({
    super.key,
    required this.text, // Text content
    this.fontSize = 16.0, // Default font size
    this.fontWeight = FontWeight.bold, // Default font weight
    this.color = const Color(0xFF77A9F5), // Default color #77a9f5
    this.textAlign = TextAlign.left, // Default text alignment
    this.decoration =
        TextDecoration.none, // Default decoration (underline, etc.)
    this.fontFamily = 'Mulish', // Default font family
    this.border = false, // By default, no border will be applied
    this.borderSide = false, // By default, border side
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // Apply bottom border conditionally
      decoration: border
          ? BoxDecoration(
              border: borderSide
                  ? Border(
                      top: BorderSide(
                        color: color, // Use the text color for the border
                        width: 2.0, // Set the width of the border
                      ),
                    )
                  : Border(
                      bottom: BorderSide(
                        color: color, // Use the text color for the border
                        width: 2.0, // Set the width of the border
                      ),
                    ),
            )
          : null, // No decoration if border is false
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          decoration: decoration,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
