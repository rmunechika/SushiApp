import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/provider/CartProvider.dart';
import 'package:sushi_app/provider/SushiCounter.dart';
import 'package:sushi_app/screens/welcome_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SushiCounter()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sushiman',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: WelcomeScreen(),
    );
  }
}
