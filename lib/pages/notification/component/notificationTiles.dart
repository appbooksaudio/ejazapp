import 'dart:core';

import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationTiles extends StatefulWidget {
  final String title, subtitle, date;
  final void Function() onTap;
  final bool enable;
  const NotificationTiles({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.onTap,
    required this.enable,
  });

  @override
  State<NotificationTiles> createState() => _NotificationTilesState();
}

class _NotificationTilesState extends State<NotificationTiles> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Container(
        height: 50, // Container height
        width: 50, // Container width
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          color: themeProv.isDarkTheme! ? Colors.white : Colors.grey.shade200,
          boxShadow: [
            if (!themeProv.isDarkTheme!)
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 5,
                offset: const Offset(2, 2),
              ),
          ],
        ),
        child: Center(
          child: SizedBox(
            height: 30, // Control image size here
            width: 30, // Control image size here
            child: Image.asset(Const.notification, fit: BoxFit.cover),
          ),
        ),
      ),
      title: Text(
        widget.title,
        style: TextStyle(
          color: themeProv.isDarkTheme! ? Colors.white : Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.subtitle,
              style: TextStyle(
                color: themeProv.isDarkTheme! ? Colors.white70 : Colors.black87,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                widget.date,
                style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onTap: widget.onTap,
      enabled: widget.enable,
    );
  }
}
