import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showNotificationDialog(BuildContext context, String? title, String? body) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing on outside tap
    builder: (BuildContext context) {
      final themeProv = Provider.of<ThemeProvider>(context);
      final localprovider = Provider.of<LocaleProvider>(context, listen: false);
      String lang = localprovider.localelang!.languageCode;
      return AlertDialog(
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey.shade200,
              child: Icon(
                Icons.notifications,
                size: 50,
                color: Colors.black,
              ),
            ),
          ],
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title ?? "New Notification",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeProv.isDarkTheme!
                    ? Colors.white
                    : ColorDark.background,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              body ?? "You have a new message",
              style: TextStyle(
                fontSize: 16,
                color: themeProv.isDarkTheme!
                    ? Colors.white
                    : ColorDark.background,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child:lang=="en"? Text("OK"):Text("شكرا"),
          ),
        ],
      );
    },
  );
}
