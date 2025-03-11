import 'package:ejazapp/core/services/services.dart';
import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/helpers/routes.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

void showPreferencePopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final localeProv = Provider.of<LocaleProvider>(context);
      bool isEnglish = localeProv.localelang!.languageCode == "en";
      final themeProv = Provider.of<ThemeProvider>(context);
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double imageHeight = constraints.maxWidth > 600 ? 300 : 150;
            double fontSizeTitle = constraints.maxWidth > 600 ? 28 : 22;
            double fontSizeSubtitle = constraints.maxWidth > 600 ? 18 : 16;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(13.0),
                          child: Image.network(
                            'https://img.freepik.com/free-vector/choose-concept-illustration_114360-553.jpg',
                            height: imageHeight,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        isEnglish ? "What Do You Prefer?" : "ما هو تفضيلك؟",
                        style: TextStyle(
                          fontSize: fontSizeTitle,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        isEnglish
                            ? "Select your preference to get the best recommendations!"
                            : "حدد تفضيلاتك للحصول على أفضل التوصيات!",
                        style: TextStyle(
                          fontSize: fontSizeSubtitle,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15), // Rounded corners
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Navigate to preferences selection screen
                          Get.toNamed<dynamic>(Routes.selectcategory);
                          mybox!.put('preference', 'home');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            isEnglish ? "SELECT PREFERENCE" : "اختر التفضيلات",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: themeProv.isDarkTheme!
                                ? Colors.white
                                : ColorDark.background,
                          ),
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15), // Rounded corners
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(isEnglish ? "NO THANKS" : "لا شكرًا",
                              style: TextStyle(
                                fontSize: 12,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: -10,
                  top: -12,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(Icons.close, color: Colors.black),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
