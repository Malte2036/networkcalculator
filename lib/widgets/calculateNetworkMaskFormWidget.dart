import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:networkcalculator/data/IPMath.dart';
import 'package:networkcalculator/data/NetworkMask.dart';
import 'package:networkcalculator/data/NetworkMaskManager.dart';

class CalculateNetworkMaskFormWidget extends StatefulWidget {
  @override
  _CalculateNetworkMaskFormWidgetState createState() =>
      _CalculateNetworkMaskFormWidgetState();
}

class _CalculateNetworkMaskFormWidgetState
    extends State<CalculateNetworkMaskFormWidget> {
  final _formKey = GlobalKey<FormState>();

  String _inputIPAddressString = '';
  int _inputSuffix = 32;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Insert IPAddress';
              }
              if (!IPMath.isValidIPv4AddressString(value) &&
                  (':'.allMatches(value).length < 2 ||
                      !IPMath.isValidIPv6AddressString(
                          IPMath.expandIPv6StringToFullIPv6String(value)))) {
                return 'No valid IPAddress';
              }
              return null;
            },
            onChanged: (value) => _inputIPAddressString = value,
            decoration: InputDecoration(
              hintText: 'Please enter IPv4Address or IPv6Address',
              labelText: 'IPAddress:',
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Insert Suffix';
              }
              if (!IPMath.isValidIPv6Suffix(value)) {
                return 'Suffix must be between 1 and 128';
              }
              return null;
            },
            onChanged: (value) {
              var parse = int.tryParse(value);
              if (parse != null) {
                _inputSuffix = parse;
              }
            },
            decoration: InputDecoration(
              hintText: 'Please enter Suffix',
              labelText: 'Suffix:',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var networkMask =
                          new NetworkMask(_inputIPAddressString, _inputSuffix);
                      NetworkMaskManager.networkMaskController.add(networkMask);
                    }
                  },
                  child: Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.reset();
                    var networkMask =
                        new NetworkMask(_inputIPAddressString, _inputSuffix);
                    NetworkMaskManager.networkMaskController.add(networkMask);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: Text('Reset'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
