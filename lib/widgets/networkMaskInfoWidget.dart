import 'dart:async';
import 'dart:core';

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
        builder: (BuildContext context, AsyncSnapshot<NetworkMask?> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final NetworkMask networkMask = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Mask was calculated:',
                textScaleFactor: 1.2,
              ),
              Table(
                border: TableBorder.all(width: 0.75, color: Colors.grey),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: networkMask
                    .printNetworkMask()
                    .map((List<String> data) => TableRow(
                          children: <SelectableText>[
                            SelectableText(data[0],
                                maxLines: 1, textScaleFactor: 1.1),
                            SelectableText(data[1],
                                maxLines: 1, textScaleFactor: 1.1),
                          ],
                        ))
                    .toList(),
              ),
            ],
          );
        });
  }
}
