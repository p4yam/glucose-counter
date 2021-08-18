import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glucose_counter/feature/home/home_page_route.dart';

import 'core/utils/app_themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: AppThemes.lightTheme,
      home: HomePageRoute(),
    );
  }
}
