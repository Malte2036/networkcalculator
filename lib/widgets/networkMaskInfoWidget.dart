import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:networkcalculator/data/NetworkMask.dart';

class NetworkMaskInfoWidget extends StatefulWidget {
  NetworkMaskInfoWidget(this.networkMaskStream);
  final StreamController<NetworkMask?> networkMaskStream;

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
    return StreamBuilder<NetworkMask?>(
        stream: widget.networkMaskStream.stream,
        builder: (BuildContext contex, AsyncSnapshot<NetworkMask?> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final NetworkMask networkMask = snapshot.data!;
          return SelectableText(networkMask.printNetworkMask());
        });
  }
}
