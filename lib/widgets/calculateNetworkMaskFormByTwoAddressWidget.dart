import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:networkcalculator/data/IPMath.dart';
import 'package:networkcalculator/data/IPv6Address.dart';
import 'package:networkcalculator/data/NetworkMask.dart';
import 'package:networkcalculator/data/NetworkMaskManager.dart';

class CalculateNetworkMaskFormByTwoAddressWidget extends StatefulWidget {
  @override
  _CalculateNetworkMaskFormByTwoAddressWidgetState createState() =>
      _CalculateNetworkMaskFormByTwoAddressWidgetState();
}

class _CalculateNetworkMaskFormByTwoAddressWidgetState
    extends State<CalculateNetworkMaskFormByTwoAddressWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _inputIPAddress1String = '';
  String _inputIPAddress2String = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Calculate the subnet based on two IP addresses:',
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
                onChanged: (String value) => _inputIPAddress1String = value,
                decoration: const InputDecoration(
                  hintText: 'Please enter IPv4Address or IPv6Address',
                  labelText: 'IPAddress 1:',
                ),
              ),
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
                onChanged: (String value) => _inputIPAddress2String = value,
                decoration: const InputDecoration(
                  hintText: 'Please enter IPv4Address or IPv6Address',
                  labelText: 'IPAddress 2:',
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
                          IPv6Address iPv6Address1 =
                              IPMath.parseIPv4OrIPv6StringToIPv6Address(
                                  _inputIPAddress1String);
                          IPv6Address iPv6Address2 =
                              IPMath.parseIPv4OrIPv6StringToIPv6Address(
                                  _inputIPAddress2String);

                          final bool isIPv4Address =
                              iPv6Address1.isIPv4Address() &&
                                  iPv6Address2.isIPv4Address();

                          if (iPv6Address1.isGreaterThan(iPv6Address2)) {
                            final IPv6Address iPv6AddressTemp = iPv6Address1;
                            iPv6Address1 = iPv6Address2;
                            iPv6Address2 = iPv6AddressTemp;
                          }

                          int smallestSuffix =
                              IPMath.getSmallestSuffixBetweenTwoIPv6Address(
                                  iPv6Address1, iPv6Address2,
                                  isIPv4Address: isIPv4Address);

                          bool success;
                          String ip = iPv6Address1.isIPv4Address()
                              ? iPv6Address1.getIPv4String()
                              : iPv6Address1.getIPv6String();

                          NetworkMask networkMask;
                          do {
                            success = true;
                            networkMask = NetworkMask(ip, smallestSuffix,
                                showIPOnPrint: false);

                            final IPv6Address networkIPv6Address =
                                networkMask.getNetworkIPv6Address();

                            if (networkIPv6Address
                                    .isGreaterThan(iPv6Address1) ||
                                networkIPv6Address
                                    .isGreaterThan(iPv6Address2)) {
                              smallestSuffix--;
                              ip = iPv6Address1.isIPv4Address()
                                  ? iPv6Address1.getIPv4String()
                                  : iPv6Address1.getIPv6String();
                              success = false;
                            } else {
                              final IPv6Address broadcastIPv6Address =
                                  networkMask.getBroadcastIPv6Address();

                              if (iPv6Address1
                                      .isGreaterThan(broadcastIPv6Address) ||
                                  iPv6Address2
                                      .isGreaterThan(broadcastIPv6Address)) {
                                final BigInt countHosts =
                                    IPMath.getCountHostsBySuffix(smallestSuffix,
                                        isIPv4Address: isIPv4Address);

                                String binaryString = IPMath.binaryPlusBinary(
                                    iPv6Address1.getBinary(),
                                    IPMath.bigIntToBinary(
                                        countHosts <= BigInt.zero
                                            ? BigInt.one
                                            : countHosts));

                                final int byteCount = isIPv4Address
                                    ? IPMath.iPv4AddressByteCount
                                    : IPMath.iPv6AddressByteCount;
                                binaryString = binaryString
                                    .padLeft(byteCount)
                                    .replaceAll(' ', '0');

                                ip = isIPv4Address
                                    ? IPMath.binaryToIPv4String(binaryString)
                                    : IPMath.binaryToIPv6String(binaryString);

                                success = false;
                              }
                            }
                          } while (!success);

                          NetworkMaskManager.networkMaskByTwoAddressController
                              .add(networkMask);
                        }
                      },
                      child: const Text('Submit'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                        NetworkMaskManager.networkMaskByTwoAddressController
                            .add(null);
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
