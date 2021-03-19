import 'package:flutter/material.dart';
import 'package:netzwerkrechner/data/IPv6Address.dart';
import 'package:netzwerkrechner/data/NetworkMask.dart';

void main() {
  IPv6Address iPv6Address = IPv6Address.fromIPString("2001:DB8:ABCD");
  NetworkMask networkMask = new NetworkMask(iPv6Address, 12);
  print(iPv6Address.getBinary().length);

  print(networkMask.printNetworkMask());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NetzwerkRechner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NetzwerkRechner"),
      ),
      body: Center(),
    );
  }
}
