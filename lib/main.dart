import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/menu_provider.dart';
import 'providers/cart_provider.dart';
import 'screens/menu_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MenuProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: const BiteDashApp(),
    ),
  );
}

class BiteDashApp extends StatelessWidget {
  const BiteDashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BiteDash',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        fontFamily: 'Poppins',
      ),
      home: const MenuPage(),
    );
  }
}