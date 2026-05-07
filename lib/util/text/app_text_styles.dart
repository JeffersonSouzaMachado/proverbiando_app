import 'package:flutter/material.dart';

abstract final class AppTextStyles {

  static const TextStyle h1 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.normal,
    fontFamily: 'Newsreader'
  );


  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: 'Newsreader'
  );


  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontFamily: 'Inter'
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}