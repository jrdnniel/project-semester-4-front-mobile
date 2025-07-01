import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pharmacy/cart_provider.dart';
import 'splash.dart'; 

void main() {
  runApp(const MyApp());
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
        debugShowCheckedModeBanner: false, 
        home: const SplashPage(), 
      ),
    );
  }
}