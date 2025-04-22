import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'menu_utama/main_page.dart';
import 'pharmacy/cart_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Doctor App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: MainPage(),
      ),
    );
  }
}