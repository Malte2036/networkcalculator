import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:networkcalculator/widgets/calculateNetworkMaskFormWidget.dart';
import 'package:networkcalculator/widgets/networkMaskInfoWidget.dart';

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
        title: Text("Network Calculator"),
      ),
      body: Container(
        child: ListView(
          children: [
            CalculateNetworkMaskFormWidget(),
            NetworkMaskInfoWidget(),
          ],
        ),
      ),
    );
  }
}
