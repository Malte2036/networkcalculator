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
  List<DataRow> getNetworkMaskDataRowList(NetworkMask networkMask) {
    final List<DataRow> dataRowList = <DataRow>[];
    final List<List<String>> printNetworkMask = networkMask.printNetworkMask();

    for (final List<String> data in printNetworkMask) {
      final List<DataCell> dataCells = <DataCell>[];

      data.forEach((element) => dataCells.add(DataCell(SelectableText(element, maxLines: 1))));

      final DataRow dataRow = DataRow(
        cells: dataCells,
      );
      dataRowList.add(dataRow);
    }
    return dataRowList;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NetworkMask?>(
        stream: widget.networkMaskStream.stream,
        builder: (BuildContext contex, AsyncSnapshot<NetworkMask?> snapshot) {
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
              DataTable(
                dividerThickness: 2,
                headingRowHeight: 0,
                dataRowHeight: 35,
                showCheckboxColumn: false,
                columns: const <DataColumn>[
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                ],
                rows: getNetworkMaskDataRowList(networkMask),
              ),
            ],
          );
        });
  }
}
