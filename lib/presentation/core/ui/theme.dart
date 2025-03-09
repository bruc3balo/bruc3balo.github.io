import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ColorPack {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color titleColor;
  final Color tileColor;

  const ColorPack({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.titleColor,
    required this.tileColor,
  });
}

Color errorColor = Colors.red;

Color orange = HexColor("#EC7F00");
Color darkBackground = HexColor("#25292D");

ColorPack darkColor = ColorPack(
  primary: HexColor("#FFFAFF"),
  secondary: HexColor("#FEFCFD"),
  background: Colors.transparent,
  titleColor: HexColor("#FFFAFF"),
  tileColor: HexColor("#EBEBEB"),
);
ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: darkColor.primary,
  onPrimary: darkColor.primary.withValues(alpha: 0.8),
  secondary: darkColor.secondary,
  onSecondary: darkColor.secondary.withValues(alpha: 0.8),
  error: errorColor,
  onError: errorColor.withValues(alpha: 0.8),
  surface: darkColor.tileColor,
  onSurface: darkColor.tileColor.withValues(alpha: 0.8),
);

ThemeData darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  appBarTheme: AppBarTheme(
    // elevation: 12.0,
    backgroundColor: Colors.transparent,
    titleTextStyle: GoogleFonts.robotoMono(
      color: darkColor.titleColor,
      fontWeight: FontWeight.bold,
      decorationThickness: 20,
      letterSpacing: 4.0,
    ),
    toolbarHeight: 70,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(darkColor.primary),
      foregroundColor: WidgetStatePropertyAll(darkColor.titleColor),
      side: WidgetStatePropertyAll(
        BorderSide(
          color: darkColor.background,
          width: 2,
        ),
      ),
      textStyle: WidgetStatePropertyAll(
        GoogleFonts.robotoMono(
          color: darkColor.tileColor,
          fontWeight: FontWeight.w700,
          letterSpacing: 2.0,
        ),
      ),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.all(10.0),
      ),
      enableFeedback: true,
    ),
  ),
  textTheme: TextTheme(
    titleLarge: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      decorationThickness: 35,
      color: darkColor.secondary,
    ),
  ),
  expansionTileTheme: ExpansionTileThemeData(
    backgroundColor: darkColor.background,
    textColor: darkColor.secondary,
    collapsedBackgroundColor: darkColor.background,
    collapsedTextColor: darkColor.tileColor,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: darkColor.titleColor,
        width: 2.0,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(0),
    ),
  ),
  listTileTheme: ListTileThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    contentPadding: const EdgeInsets.all(10.0),
    tileColor: darkColor.background,
    titleTextStyle: GoogleFonts.robotoMono(
      color: darkColor.secondary,
      fontWeight: FontWeight.w600,
      fontSize: 18,
      wordSpacing: 3.0,
      letterSpacing: 2.0,
    ),
    subtitleTextStyle: GoogleFonts.robotoMono(
      color: darkColor.secondary,
      fontWeight: FontWeight.normal,
      fontSize: 14,
    ),
  ),
  cardTheme: CardTheme(
    color: darkColor.background,
    surfaceTintColor: darkBackground,
    shadowColor: darkBackground,
    elevation: 6.0,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: darkColor.background,
  ),
  scaffoldBackgroundColor: darkColor.background,
);
