import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:world_news/views/homepage.dart';

void main() async {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      // locale: DevicePreview.of(context).locale,
      builder: DevicePreview.appBuilder,
      title: 'eCommerce int2',
      debugShowCheckedModeBanner: false,
      // routes: AppRoutes.define(),
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        canvasColor: Colors.transparent,
        primaryColor: Colors.white,
        fontFamily: "Montserrat",
      ),
      home: Home(),
      // HomePagee(),
    );
  }
}
