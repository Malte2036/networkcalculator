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
  List<TableRow> getNetworkMaskTableRowList(NetworkMask networkMask) {
    final List<TableRow> tableRowList = <TableRow>[];
    final List<List<String>> printNetworkMask = networkMask.printNetworkMask();

    for (final List<String> data in printNetworkMask) {
      final List<Widget> dataCells = <Widget>[];

      data.forEach((String element) => dataCells
          .add(SelectableText(element, maxLines: 1, textScaleFactor: 1.1)));

      final TableRow dataRow = TableRow(
        children: dataCells,
      );
      tableRowList.add(dataRow);
    }
    return tableRowList;
  }

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
                style: TextStyle(fontSize: 17),
              ),
              Table(
                border: TableBorder.all(width: 0.75, color: Colors.grey),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: getNetworkMaskTableRowList(networkMask),
              ),
            ],
          );
        });
  }
}
