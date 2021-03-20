import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netzwerkrechner/widgets/calculateNetworkMaskFormWidget.dart';
import 'package:netzwerkrechner/widgets/networkMaskInfoWidget.dart';

class NetworkManagerMainScreen extends StatefulWidget {
  @override
  _NetworkManagerMainScreenState createState() =>
      _NetworkManagerMainScreenState();
}

class _NetworkManagerMainScreenState extends State<NetworkManagerMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Netzwerk Rechner"),
      ),
      body: NetworkMaskInfoWidget(),
    );
  }
}
