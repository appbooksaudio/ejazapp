
import 'package:flutter/material.dart';

class RectangularButton extends StatelessWidget {
  const RectangularButton({
    super.key,
    this.child,
    this.backGroundColor,
    this.action,
  });

  final Widget? child;
  final Color? backGroundColor;
  final Function()? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: action,
      child: Container(
        decoration: BoxDecoration(
            color: backGroundColor ?? theme.cardColor,
            borderRadius: BorderRadius.circular(8)),
        height: 44,
        width: 44,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
