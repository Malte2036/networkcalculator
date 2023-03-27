import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:networkcalculator/bloc/NetworkMaskBloc.dart';
import 'package:networkcalculator/ui/widgets/calculateNetworkMaskFormByTwoAddressWidget.dart';
import 'package:networkcalculator/ui/widgets/calculateNetworkMaskFormWidget.dart';
import 'package:networkcalculator/ui/widgets/networkMaskInfoWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class NetworkManagerMainScreen extends StatefulWidget {

  @override
  _NetworkManagerMainScreenState createState() =>
      _NetworkManagerMainScreenState();
}

class _NetworkManagerMainScreenState extends State<NetworkManagerMainScreen> {

  final String _sourceCodeUrl =
      'https://github.com/Malte2036/networkcalculator';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Network Calculator'),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: Container(
          margin: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              CalculateNetworkMaskFormWidget(networkMaskBloc.networkMaskBySuffixSink),
              NetworkMaskInfoWidget(
                  networkMaskBloc.networkMaskBySuffixStream),
              const Divider(
                color: Colors.black,
                height: 25,
                thickness: 2,
                indent: 5,
                endIndent: 5,
              ),
              CalculateNetworkMaskFormByTwoAddressWidget(networkMaskBloc.networkMaskByTwoAddressSink),
              NetworkMaskInfoWidget(
                  networkMaskBloc.networkMaskByTwoAddressStream),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: const Color.fromRGBO(233, 236, 239, 1),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Text('©2023 Malte Sehmer'),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.blueAccent,
                  ),
                  onPressed: () async => canLaunch(_sourceCodeUrl) != null
                      ? await launch(_sourceCodeUrl)
                      : throw 'Could not launch $_sourceCodeUrl',
                  child: const Text('Source-Code'),
                )
              ],
            ),
          ),
        ));
  }
}
