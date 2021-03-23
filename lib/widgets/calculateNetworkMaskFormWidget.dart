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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _inputIPAddressString = '';
  int _inputSuffix = 32;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Calculate the subnet based on an IP address and the CIDR suffix:',
          style: TextStyle(fontSize: 17),
        ),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Insert IPAddress';
                  }
                  if (!IPMath.isValidIPv4AddressString(value) &&
                      (':'.allMatches(value).length < 2 ||
                          !IPMath.isValidIPv6AddressString(
                              IPMath.expandIPv6StringToFullIPv6String(
                                  value)))) {
                    return 'No valid IPAddress';
                  }
                  return null;
                },
                onChanged: (String value) => _inputIPAddressString = value,
                decoration: const InputDecoration(
                  hintText: 'Please enter IPv4Address or IPv6Address',
                  labelText: 'IPAddress:',
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Insert Suffix';
                  }
                  final int? suffixInt = int.tryParse(value);
                  if (suffixInt == null) {
                    return 'Suffix should be an integer';
                  }
                  if (!IPMath.isValidIPv6Suffix(suffixInt)) {
                    return 'Suffix must be between 1 and 128';
                  }
                  return null;
                },
                onChanged: (String value) {
                  final int? parse = int.tryParse(value);
                  if (parse != null) {
                    _inputSuffix = parse;
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Please enter Suffix',
                  labelText: 'Suffix:',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final NetworkMask networkMask =
                              NetworkMask(_inputIPAddressString, _inputSuffix);
                          NetworkMaskManager.networkMaskBySuffixController
                              .add(networkMask);
                        }
                      },
                      child: const Text('Submit'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                        NetworkMaskManager.networkMaskBySuffixController.add(null);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
