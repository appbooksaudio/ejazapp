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
import 'package:firebase_remote_config/firebase_remote_config.dart';

bool _hasSkippedUpdate = false; // Session flag

Future<void> checkForUpdate(BuildContext context) async {
  if (_hasSkippedUpdate) return; // Skip if user tapped "Later"
  try {
    final remoteConfig = FirebaseRemoteConfig.instance;
    // Set config settings to allow immediate fetching
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 10),
      minimumFetchInterval: Duration.zero, // <- Force fetch every time
    ));

    // Fetch and activate
    await remoteConfig.fetchAndActivate();
    // Get current app version
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;
    String packageName = packageInfo.packageName;

    String latestVersion = "";

    if (Platform.isAndroid) {
      latestVersion = await getLatestVersionFromGooglePlay(packageName);
    } else if (Platform.isIOS) {
      latestVersion = remoteConfig.getString('minimum_ios_version');
    } else {
      print("Unsupported platform");
      return;
    }

    print("Current version: $currentVersion");
    print("Latest version: $latestVersion");

    if (_isNewVersionAvailable(currentVersion, latestVersion)) {
      final localprovider = Provider.of<LocaleProvider>(context, listen: false);
      final themeProv = Provider.of<ThemeProvider>(context, listen: false);
      _showUpdateDialog(context, localprovider, themeProv);
    }
  } catch (e) {
    print("Error checking for update: $e");
  }
}

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
  throw Exception("Failed to fetch version from Google Play");
}

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
  bool isArabic = localprovider.localelang?.languageCode == "ar";

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey.shade200,
                  child:
                      Icon(Icons.system_update, size: 50, color: Colors.black),
                ),
                SizedBox(height: 20),
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
                Text(
                  isArabic
                      ? "يتوفر إصدار جديد من هذا التطبيق. يرجى التحديث الآن."
                      : "A new version of this app is available. Please update now.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: themeProv.isDarkTheme!
                        ? Colors.white
                        : ColorDark.background,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        _hasSkippedUpdate = true;
                        Navigator.of(context).pop();
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
                      onPressed: _launchStore,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
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

void _launchStore() async {
  String androidUrl =
      "https://play.google.com/store/apps/details?id=com.ejazapphbku.ejazapp";
  String iosUrl = "https://apps.apple.com/app/ejaz-books/id6450498323";

  String url = Platform.isIOS ? iosUrl : androidUrl;

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw "Could not launch store link";
  }
}
