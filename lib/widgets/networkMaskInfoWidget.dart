import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:networkcalculator/data/NetworkMask.dart';
import 'package:networkcalculator/data/NetworkMaskManager.dart';

class NetworkMaskInfoWidget extends StatefulWidget {
  final _NetworkMaskInfoWidgetState currentNetworkMaskInfoWidgetState =
      _NetworkMaskInfoWidgetState();

  @override
  _NetworkMaskInfoWidgetState createState() {
    return _NetworkMaskInfoWidgetState();
  }
}

class _NetworkMaskInfoWidgetState extends State<NetworkMaskInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: NetworkMaskManager.networkMaskController.stream,
        builder: (BuildContext contex, AsyncSnapshot<NetworkMask> snapshot) {
          if (!snapshot.hasData) {
            return Text('No Data!');
          }
          NetworkMask networkMask = snapshot.data!;
          return SelectableText(networkMask.printNetworkMask());
        });
  }
}
