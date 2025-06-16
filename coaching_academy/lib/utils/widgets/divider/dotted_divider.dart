import 'package:flutter/material.dart';

class CustomDottedDivider extends StatelessWidget {
  final double dotHeight;
  final double dotWidth;
  final Color color;
  final double spacing;

  const CustomDottedDivider({
    super.key,
    this.dotHeight = 2,
    this.dotWidth = 4,
    this.color = Colors.black,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.constrainWidth();
        final dotCount = (width / (dotWidth + spacing)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dotCount, (index) {
            return Container(
              width: dotWidth,
              height: dotHeight,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.rectangle,
              ),
            );
          }),
        );
      },
    );
  }
}
