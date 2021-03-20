import 'package:flutter/material.dart';
import 'package:netzwerkrechner/data/IPv6Address.dart';
import 'package:netzwerkrechner/data/NetworkMask.dart';
import 'package:netzwerkrechner/screens/networkManagerMainScreen.dart';

void main() {
  /*IPv6Address iPv6Address = IPv6Address.fromIPString("2001:0DB8:ABCD:0012:0000:0000:0000:0000");
  NetworkMask networkMask = new NetworkMask(iPv6Address, 80);

  print(networkMask.printNetworkMask());*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NetzwerkRechner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NetworkManagerMainScreen(),
    );
  }
}