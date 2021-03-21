import 'package:flutter/material.dart';
import 'package:networkcalculator/screens/networkManagerMainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Map<int, Color> color = <int, Color>{
    50: const Color.fromRGBO(255, 255, 255, 1),
    100: const Color.fromRGBO(248, 249, 250, 1),
    200: const Color.fromRGBO(233, 236, 239, 1),
    300: const Color.fromRGBO(222, 226, 230, 1),
    400: const Color.fromRGBO(206, 212, 218, 1),
    500: const Color.fromRGBO(173, 181, 189, 1),
    600: const Color.fromRGBO(108, 117, 125, 1),
    700: const Color.fromRGBO(73, 80, 87, 1),
    800: const Color.fromRGBO(52, 58, 64, 1),
    900: const Color.fromRGBO(33, 37, 41, 1)
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Network Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF212529, color),
      ),
      home: NetworkManagerMainScreen(),
    );
  }
}
