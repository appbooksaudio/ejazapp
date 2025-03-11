import 'package:ejazapp/data/datasource/remote/listapi/getdataserver.dart';
import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/helpers/routes.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ErrorPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final booksApi = Provider.of<BooksApi>(context, listen: false);
    final themeProv = Provider.of<ThemeProvider>(context);
    final localprovider = Provider.of<LocaleProvider>(context, listen: true);
    String lang = localprovider.localelang!.languageCode;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey.shade200,
              child: Icon(
                Icons.wifi_off,
                size: 50,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              lang == "en" ? "Something went wrong" : "حدث خطأ ما",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeProv.isDarkTheme! ? Colors.white : ColorDark.background,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              lang == "en"
                  ? "Oops! We're having trouble connecting. Mind trying again?"
                  : "عذرًا! نواجه مشكلة في الاتصال. هل يمكنك المحاولة مرة أخرى؟",
              style: TextStyle(
                fontSize: 16,
                color:themeProv.isDarkTheme! ? Colors.white : ColorDark.background,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  booksApi.hasMoreBooks=true;
                  Get.toNamed(Routes.home,
                      preventDuplicates:
                          false); // Push home route again to refresh
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  lang == "en" ? "Try again" : "حاول مرة أخرى",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
