import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class MainAppFunctions {
  static removeSplash() async {
    await Future.delayed(const Duration(milliseconds: 200));
    FlutterNativeSplash.remove();
  }

  static statusbarColor() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        // navigation bar color
        statusBarColor: Colors.black.withOpacity(0.0),
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark // status bar color
        ));
  }
}
