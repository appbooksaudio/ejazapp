import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeLightAr = ThemeData(
  brightness: Brightness.light,
  primaryIconTheme: const IconThemeData(
    color: ColorLight.fontTitle,
    size: 20,
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: ColorLight.primary,
    onPrimary: ColorLight.primary,
    secondary: ColorLight.secondary,
    onSecondary: ColorLight.secondary,
    error: ColorLight.error,
    onError: ColorLight.error,
    surface: ColorLight.background,
    onSurface: ColorLight.background, background: Colors.transparent, onBackground: Colors.transparent,
  ),
  primaryColor: ColorLight.primary,
  cardColor: ColorLight.card,
  disabledColor: ColorLight.disabled,
  hintColor: ColorLight.hint,
  indicatorColor: ColorLight.primary,
  buttonTheme: ButtonThemeData(
    disabledColor: ColorLight.disabledButton,
    buttonColor: ColorLight.primary,
    height: 45,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Const.radius),
    ),
  ),
  iconTheme: const IconThemeData(color: ColorLight.fontTitle),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: ColorLight.primary,
  ),
  scaffoldBackgroundColor: ColorLight.background,
  appBarTheme: const AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
    centerTitle: true,
  ),
  textTheme: GoogleFonts.notoKufiArabicTextTheme().copyWith(
    headlineLarge: GoogleFonts.barlow(
      color: ColorLight.fontTitle,
      fontSize: 22,
      fontWeight: FontWeight.w500,
    ),
    headlineMedium: GoogleFonts.notoKufiArabic(
      color: ColorLight.fontTitle,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: GoogleFonts.notoKufiArabic(
      color: ColorLight.fontTitle,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    labelLarge: GoogleFonts.notoKufiArabic(
      color: ColorLight.fontTitle,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: GoogleFonts.notoKufiArabic(
      color: ColorLight.fontTitle,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: GoogleFonts.notoKufiArabic(
      color: ColorLight.fontTitle,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: GoogleFonts.notoKufiArabic(
      color: ColorLight.fontTitle,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    titleMedium: GoogleFonts.notoKufiArabic(
      color: ColorLight.fontTitle,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    titleSmall: GoogleFonts.notoKufiArabic(
      color: ColorLight.fontTitle,
      fontSize: 10,
      fontWeight: FontWeight.normal,
    ),
    bodyLarge: GoogleFonts.notoSansArabic(
      color: ColorLight.fontSubtitle,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: GoogleFonts.notoKufiArabic(
      color: ColorLight.fontSubtitle,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: GoogleFonts.notoKufiArabic(
      color: ColorLight.fontSubtitle,
      fontSize: 10,
      fontWeight: FontWeight.normal,
    ),
  ),
);

ThemeData themeDarkAr = ThemeData(
  brightness: Brightness.dark,
  primaryIconTheme: const IconThemeData(
    color: ColorDark.fontTitle,
    size: 20,
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: ColorDark.primary,
    onPrimary: ColorDark.primary,
    secondary: ColorDark.secondary,
    onSecondary: ColorDark.secondary,
    error: ColorDark.error,
    onError: ColorDark.error,
    surface: ColorDark.background,
    onSurface: ColorDark.background, background: Colors.transparent, onBackground: Colors.transparent,
  ),
  primaryColor: ColorDark.primary,
  cardColor: ColorDark.card,
  disabledColor: ColorDark.disabled,
  hintColor: ColorDark.hint,
  indicatorColor: ColorDark.primary,
  buttonTheme: ButtonThemeData(
    disabledColor: ColorDark.disabledButton,
    buttonColor: ColorDark.primary,
    height: 45,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Const.radius),
    ),
  ),
  iconTheme: const IconThemeData(color: ColorDark.fontTitle),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: ColorDark.primary,
  ),
  scaffoldBackgroundColor: ColorDark.background,
  appBarTheme: const AppBarTheme(
    color: ColorDark.background,
    elevation: 0,
    centerTitle: true,
  ),
  textTheme: GoogleFonts.notoKufiArabicTextTheme().copyWith(
    headlineLarge: GoogleFonts.notoKufiArabic(
      color: ColorDark.fontTitle,
      fontSize: 22,
      fontWeight: FontWeight.w500,
    ),
    headlineMedium: GoogleFonts.notoKufiArabic(
      color: ColorDark.fontTitle,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: GoogleFonts.notoKufiArabic(
      color: ColorDark.fontTitle,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    labelLarge: GoogleFonts.notoKufiArabic(
      color: ColorDark.fontTitle,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: GoogleFonts.notoKufiArabic(
      color: ColorDark.black,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: GoogleFonts.notoKufiArabic(
      color: ColorDark.fontTitle,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: GoogleFonts.notoKufiArabic(
      color: ColorDark.fontTitle,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    titleMedium: GoogleFonts.notoKufiArabic(
      color: ColorDark.fontTitle,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    titleSmall: GoogleFonts.notoKufiArabic(
      color: ColorDark.fontTitle,
      fontSize: 10,
      fontWeight: FontWeight.normal,
    ),
    bodyLarge: GoogleFonts.notoSansArabic(
      color: ColorDark.fontSubtitle,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: GoogleFonts.notoKufiArabic(
      color: ColorDark.fontSubtitle,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: GoogleFonts.notoKufiArabic(
      color: ColorDark.fontSubtitle,
      fontSize: 10,
      fontWeight: FontWeight.normal,
    ),
  ),
);
