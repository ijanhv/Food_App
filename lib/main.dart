import 'package:dineout/pages/categories_page.dart';
import 'package:dineout/pages/home_page.dart';
import 'package:dineout/pages/login_page.dart';
import 'package:dineout/pages/profile_page.dart';
import 'package:dineout/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
