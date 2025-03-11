import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class ChatCategoryButton extends StatefulWidget {
  const ChatCategoryButton({
    super.key,
    required this.text,
    required this.action,
    required this.isSelected,
  });

  final String text;
  final Function() action;
  final bool isSelected;

  @override
  State<ChatCategoryButton> createState() => _ChatCategoryButtonState();
}

class _ChatCategoryButtonState extends State<ChatCategoryButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        widget.action();
      },
      child: Container(
        decoration: BoxDecoration(
          color: ((themeProv.isDarkTheme ?? false)
              ? theme.cardColor
              : Color(0xff222743).withAlpha(20)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
          child: Text(
            widget.text,
            style: TextStyle(
                fontSize: 13,
                fontWeight:
                    widget.isSelected ? FontWeight.w700 : FontWeight.w400,
                color: widget.isSelected
                    ? (themeProv.isDarkTheme ?? false
                        ? Colors.white
                        : Color(0xff222743))
                    : Color(0xffA8A8A8)),
          ),
        ),
      ),
    );
  }
}