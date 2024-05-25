import 'package:flutter/material.dart';
import 'package:twister_app/themes_constants.dart';

ThemeData getThemeData(BuildContext context, MyTheme theme) =>
    ThemeData.light().copyWith(
      primaryColor: theme.primary,
      secondaryHeaderColor: theme.secondary,
      scaffoldBackgroundColor: theme.background,
      dividerColor: const Color.fromRGBO(220, 220, 220, 1),
      iconTheme: IconThemeData(color: theme.primary),
      textTheme: Theme.of(context).textTheme.apply(
            fontFamily: 'Montserrat',
            bodyColor: theme.text,
            displayColor: theme.text,
          ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: theme.secondary,
        iconTheme: IconThemeData(color: theme.text),
        titleTextStyle: TextStyle(
          color: theme.text,
          fontFamily: "Montserrat",
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: theme.text),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primary,
          disabledBackgroundColor: theme.disable,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 16.0,
            fontFamily: "Montserrat",
          ),
          elevation: 3,
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 16.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: TextStyle(
            fontFamily: "Montserrat",
            color: theme.primary,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: theme.text,
        ),
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide.none,
        ),
        fillColor: theme.secondary,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: theme.chip,
        deleteIconColor: theme.primary,
        shadowColor: Colors.black,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: theme.snack,
        contentTextStyle: TextStyle(
          fontSize: 16.0,
          fontFamily: "Montserrat",
          color: theme.secondary,
        ),
      ),
      dialogBackgroundColor: theme.background,
      dialogTheme: const DialogTheme(
        alignment: Alignment.center,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      colorScheme: ColorScheme.light(
        brightness: theme.brightness,
        primary: theme.primary,
        secondary: theme.secondary,
      ).copyWith(background: theme.background),
    );
