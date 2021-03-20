import 'package:flutter/widgets.dart';
import 'package:netzwerkrechner/data/IPv6Address.dart';
import 'package:netzwerkrechner/data/NetworkMask.dart';

class NetworkMaskInfoWidget extends StatefulWidget {
  @override
  _NetworkMaskInfoWidgetState createState() => _NetworkMaskInfoWidgetState();
}

class _NetworkMaskInfoWidgetState extends State<NetworkMaskInfoWidget> {
  NetworkMask networkMask =
      new NetworkMask("2001:0DB8:ABCD:0012:0000:0000:0000:0000", 80);

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: [
        Text("Data:"),
        Text("IP: " + networkMask.getIPv6Address().getIPString()),
        Text("Prefix: " + networkMask.getPrefix().toString()),
        Text("Mask: " + networkMask.getMaskIPv6Address().getIPString()),
        Text("Network: " + networkMask.getNetworkIPv6Address().getIPString()),
        Text("Broadcast: " +
            networkMask.getBroadcastIPv6Address().getIPString()),
        Text("min Host: " + networkMask.getMinHostIPv6Address().getIPString()),
        Text("max Host: " + networkMask.getMaxHostIPv6Address().getIPString()),
      ],
    );
  }
}
