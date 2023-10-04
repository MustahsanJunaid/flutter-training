import 'package:flutter/cupertino.dart';

class ScreenBreakPoints {
  static double desktop = 900;
  static double tablet = 600;
  static double handset = 300;

  static bool isTablet(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= tablet;
  }
}
