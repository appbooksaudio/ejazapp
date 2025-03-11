import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  const SquareButton({
    super.key,
    this.child,
    this.backGroundColor,
    this.action, this.size,
  });

  final Widget? child;
  final Color? backGroundColor;
  final Function()? action;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: action,
      child: Container(
        decoration: BoxDecoration(
            color: backGroundColor ?? theme.cardColor,
            borderRadius: BorderRadius.circular(8)),
        height:size?? 44,
        width: size??44,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}