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

  String _inputIPv6AddressString = '';
  int _inputPrefix = 32;

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
                return 'Insert IPv6Address';
              }
              if (!IPMath.isValidIPv6AddressString(value)) {
                return 'No valid IPv6Address';
              }
              return null;
            },
            initialValue: _inputIPv6AddressString,
            onChanged: (value) => _inputIPv6AddressString = value,
            decoration: InputDecoration(
              hintText: 'Please enter IPv6Address',
              labelText: 'IPv6Address:',
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Insert Prefix';
              }
              if(!IPMath.isValidIPv6Prefix(value)){
                return 'Prefix must be between 1 and 128';
              }
              return null;
            },
            initialValue: _inputPrefix.toString(),
            onChanged: (value) => _inputPrefix = int.parse(value),
            decoration: InputDecoration(
              hintText: 'Please enter Prefix',
              labelText: 'Prefix:',
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
                      var networkMask = new NetworkMask(
                          _inputIPv6AddressString, _inputPrefix);
                      NetworkMaskManager.networkMaskController.add(networkMask);
                    }
                  },
                  child: Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.reset();
                    var networkMask =
                        new NetworkMask(_inputIPv6AddressString, _inputPrefix);
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
