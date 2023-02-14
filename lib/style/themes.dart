// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/style/colors.dart';

ThemeData darkTheam = ThemeData(
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: HexColor('333739'),
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light),
      backgroundColor: HexColor('333739'),
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      elevation: 20.0,
      backgroundColor: HexColor('333739'),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 15.0, fontWeight: FontWeight.w600, color: Colors.white),
      subtitle1: TextStyle(
          fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.white,height: 1.3),
    ),
    fontFamily: 'jannah');

ThemeData lightTheam = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backgroundColor: Colors.white,
    backwardsCompatibility: false,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
    subtitle1: TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.black,height: 1.3),
  ),
  fontFamily: 'jannah',
);
