import 'package:flutter/material.dart';
import 'package:super_app/features/customer/home/home_page.dart';

void main() {
  runApp(const SuperApp());
}

class SuperApp extends StatelessWidget {
  const SuperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Super App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}