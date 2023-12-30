import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:calculator/viewmodels/calculator_viewmodel.dart';
import 'package:calculator/screens/calculator_screen.dart';
import 'package:calculator/viewmodels/theme_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalculatorViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var viewmodel = context.watch<ThemeViewModel>();

    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Pretendard",
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: viewmodel.primaryColor,
          brightness: viewmodel.themeBrightness,
        ),
      ),
      home: const CalculatorScreen(),
    );
  }
}
