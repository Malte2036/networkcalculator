import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:networkcalculator/data/NetworkMaskManager.dart';
import 'package:networkcalculator/widgets/calculateNetworkMaskFormByTwoAddressWidget.dart';
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
        title: const Text('Network Calculator'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            CalculateNetworkMaskFormWidget(),
            NetworkMaskInfoWidget(
                NetworkMaskManager.networkMaskBySuffixController),
            const Divider(
              color: Colors.black,
              height: 25,
              thickness: 2,
              indent: 5,
              endIndent: 5,
            ),
            CalculateNetworkMaskFormByTwoAddressWidget(),
            NetworkMaskInfoWidget(
                NetworkMaskManager.networkMaskByTwoAddressController),
          ],
        ),
      ),
    );
  }
}
