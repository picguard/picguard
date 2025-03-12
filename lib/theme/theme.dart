// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:picguard/generated/colors.gen.dart';

///
class AppTheme {
  ///
  static ThemeData get light {
    return ThemeData(
      unselectedWidgetColor: PGColors.borderColor,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'NotoSansSC',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.all(Colors.white),
        checkColor: WidgetStateProperty.all(PGColors.primaryColor),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all(PGColors.primaryColor),
      ),
      dividerTheme: const DividerThemeData(
        color: Colors.transparent,
      ),
      cardTheme: CardTheme(
        clipBehavior: Clip.hardEdge,
        color: Colors.white,
        shadowColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: PGColors.placeholderTextColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: PGColors.borderColor,
          ),
          gapPadding: 0,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: PGColors.borderColor,
          ),
          gapPadding: 0,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: PGColors.primaryColor,
          ),
          gapPadding: 0,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: PGColors.errorTextColor,
          ),
          gapPadding: 0,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: PGColors.errorTextColor,
          ),
          gapPadding: 0,
        ),
        errorStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: PGColors.errorTextColor,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(
        accentColor: PGColors.primaryColor,
      ),
      tabBarTheme: const TabBarTheme(
        tabAlignment: TabAlignment.start,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: PGColors.primaryBackgroundColor,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  ///
  static ThemeData get dark {
    return ThemeData(
      unselectedWidgetColor: PGColors.borderColor,
      scaffoldBackgroundColor: Colors.black,
      brightness: Brightness.dark,
      fontFamily: 'NotoSansSC',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.black,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        surfaceTintColor: PGColors.dialogBackgroundColor,
        backgroundColor: PGColors.dialogBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.all(Colors.white),
        checkColor: WidgetStateProperty.all(PGColors.primaryColor),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all(PGColors.primaryColor),
      ),
      dividerTheme: const DividerThemeData(
        color: Colors.transparent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: PGColors.placeholderTextColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: PGColors.borderColor,
          ),
          gapPadding: 0,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: PGColors.borderColor,
          ),
          gapPadding: 0,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: PGColors.primaryColor,
          ),
          gapPadding: 0,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: PGColors.errorTextColor,
          ),
          gapPadding: 0,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: PGColors.errorTextColor,
          ),
          gapPadding: 0,
        ),
        errorStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: PGColors.errorTextColor,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        accentColor: PGColors.primaryColor,
      ),
      tabBarTheme: const TabBarTheme(
        tabAlignment: TabAlignment.start,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: PGColors.dialogBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          // side: const BorderSide(color: placeholderTextColor),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: PGColors.primaryBackgroundColor,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
