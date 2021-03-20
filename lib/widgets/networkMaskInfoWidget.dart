import 'package:flutter/widgets.dart';

class NetworkMaskInfoWidget extends StatefulWidget {
  final _NetworkMaskInfoWidgetState currentNetworkMaskInfoWidgetState =
      _NetworkMaskInfoWidgetState();

  @override
  _NetworkMaskInfoWidgetState createState() {
    return _NetworkMaskInfoWidgetState();
  }
}

class _NetworkMaskInfoWidgetState extends State<NetworkMaskInfoWidget> {
  String printNetworkMask = "No Data!";

  @override
  Widget build(BuildContext context) {
    return Text(
      printNetworkMask + " ",
    );
  }
}
