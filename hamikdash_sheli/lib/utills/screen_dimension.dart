import 'package:flutter/material.dart';

extension ScreenDimension on num {
  double percentOfScreenWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * this / 100;
	}

  double percentOfScreenHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * this / 100;
	}
}
