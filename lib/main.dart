import 'package:flutter/material.dart';

import 'catalog_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Каталог товаров',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff235848)),
        scaffoldBackgroundColor: const Color(0xfffafbf9),
      ),
      home: const CatalogScreen(),
    );
  }
}
