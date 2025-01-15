
import 'package:flutter/material.dart';

class SeenTick extends StatelessWidget {
  const SeenTick({
    super.key, required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 16,
        width: 14,
        child: Stack(
          children: [
            Positioned(
              child: Icon(
                Icons.check,
                color: color,
                size: 13,
              ),
              left: 1,
              bottom: 5,
            ),
            Icon(
              Icons.check,
              color: color,
              size: 16,
            ),
          ],
        ));
  }
}