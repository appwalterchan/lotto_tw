import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotto_tw/page/main_page.dart';

import 'constant/locale_string.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  get storage => null;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      locale: const Locale('en', 'US'),
      theme: ThemeData(
          //    useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          primaryColor: Colors.blue[50]),
      home: const MainPage(),
    );
  }
}
