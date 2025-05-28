import 'package:chat_app/chat/chat_screen.dart';
import 'package:chat_app/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'chat_list/chat_list_screen.dart'; // your chat list screen import
import 'providers/theme_provider.dart'; // your theme provider import
import 'providers/locale_provider.dart'; // new locale provider import
import 'l10n/app_localizations.dart'; // your localization delegate

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue,primary: Colors.blue,),
       scaffoldBackgroundColor: Colors.white, // 👈 Fixed background for all screens

      ),
      locale: localeProvider.locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => const ChatListScreen(),
        '/chat': (context) => const ChatScreen(),
      },
    );
  }
}
