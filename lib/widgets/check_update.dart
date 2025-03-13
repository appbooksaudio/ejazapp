import 'dart:convert';
import 'dart:io';
import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

Future<void> checkForUpdate(BuildContext context) async {
  try {
     // Ensure it runs only on Android
    if (!Platform.isAndroid) {
      print("Skipping update check (not Android)");
      return;
    }
    // Get the installed app version
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version; // Example: "1.0.0"
    String packageName = packageInfo.packageName; // Your app's package name
    print("current version is ${currentVersion}");
    // Get latest version from Google Play Store or Apple App Store
    String latestVersion = Platform.isAndroid
        ? await getLatestVersionFromGooglePlay(packageName)
        : await getLatestVersionFromAppleStore(
            "6450498323"); //com.ejazapphbku.ejazapp Replace with your Apple App ID
    print("latestVersion version is ${latestVersion}");
    // Compare versions
    if (_isNewVersionAvailable(currentVersion, latestVersion)) {
      // Get Provider values BEFORE calling the function
      final localprovider = Provider.of<LocaleProvider>(context, listen: false);
      final themeProv = Provider.of<ThemeProvider>(context, listen: false);
      _showUpdateDialog(context, localprovider, themeProv);
    }
  } catch (e) {
    print("Error checking update: $e");
  }
}

// Fetch latest version from Google Play Store
Future<String> getLatestVersionFromGooglePlay(String packageName) async {
  final url =
      "https://play.google.com/store/apps/details?id=$packageName&hl=en";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final regex = RegExp(r'\[\[\["([0-9]+(?:\.[0-9]+)*)"\]\],');
    final match = regex.firstMatch(response.body);
    if (match != null) {
      return match.group(1)!;
    }
  }
  throw Exception("Failed to fetch version from Play Store");
}

// Fetch latest version from Apple App Store
Future<String> getLatestVersionFromAppleStore(String appId) async {
  final url = 'https://itunes.apple.com/lookup?bundleId=$appId&timestamp=${DateTime.now().millisecondsSinceEpoch}';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    if (json["resultCount"] > 0) {
      return json["results"][0]["version"];
    }
  }
  throw Exception("Failed to fetch version from Apple Store");
}

// Function to compare versions
 bool _isNewVersionAvailable(String currentVersion, String storeVersion) {
  List<int> current = currentVersion.split('.').map(int.parse).toList();
  List<int> store = storeVersion.split('.').map(int.parse).toList();

  int length = store.length > current.length ? store.length : current.length;
  for (int i = 0; i < length; i++) {
    int currentPart = (i < current.length) ? current[i] : 0;
    int storePart = (i < store.length) ? store[i] : 0;

    if (storePart > currentPart) return true;
    if (storePart < currentPart) return false;
  }
  return false;
}

void _showUpdateDialog(BuildContext context, LocaleProvider localprovider,
    ThemeProvider themeProv) {
  // Detect device language
  bool isArabic = localprovider.localelang!.languageCode == "ar";
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing when tapping outside
    builder: (BuildContext context) {
      return Directionality(
        textDirection: isArabic
            ? TextDirection.rtl
            : TextDirection.ltr, // Set text direction
        child: Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), // Rounded corners
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Update Illustration
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(
                    Icons.system_update,
                    size: 50,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),

                // Title
                Text(
                  isArabic ? "تحديث متوفر" : "Update Available",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: themeProv.isDarkTheme!
                        ? Colors.white
                        : ColorDark.background,
                  ),
                ),
                const SizedBox(height: 10),

                // Description
                Text(
                  isArabic
                      ? "يتوفر إصدار جديد من هذا التطبيق. يرجى التحديث الآن للحصول على أحدث الميزات والتحسينات."
                      : "A new version of this app is available. Please update now for the latest features and improvements.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: themeProv.isDarkTheme!
                        ? Colors.white
                        : ColorDark.background,
                  ),
                ),
                const SizedBox(height: 20),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                      },
                      child: Text(
                        isArabic ? "لاحقاً" : "Later",
                        style: TextStyle(
                          fontSize: 16,
                          color: themeProv.isDarkTheme!
                              ? Colors.white
                              : ColorDark.background,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _launchStore(); // Open the app store
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Primary color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: Text(
                        isArabic ? "تحديث" : "Update",
                        style: TextStyle(
                          fontSize: 16,
                          color: themeProv.isDarkTheme!
                              ? Colors.white
                              : ColorDark.background,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

// Function to open the Google Play Store or Apple App Store
void _launchStore() async {
  String googlePlayUrl =
      "https://play.google.com/store/apps/details?id=com.ejazapphbku.ejazapp"; // Change to your package name
  String appleStoreUrl =
      "https://apps.apple.com/app/ejaz-books/id6450498323"; // Replace with your Apple App ID

  String storeUrl = Platform.isAndroid ? googlePlayUrl : appleStoreUrl;

  if (await canLaunch(storeUrl)) {
    await launch(storeUrl);
  } else {
    throw "Could not launch store link";
  }
}
