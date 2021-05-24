import 'package:networkcalculator/bloc/data/IPMath.dart';
import 'package:networkcalculator/bloc/data/IPv6Address.dart';

class NetworkMask {
  NetworkMask(String iPString, int suffix, {bool showIPOnPrint = true}) {
    _showIPOnPrint = showIPOnPrint;

    _isIPv4Address = IPMath.isValidIPv4AddressString(iPString);
    if (_isIPv4Address) {
      _iPv6Address = IPMath.iPv4StringToIPv6Address(iPString);
    } else {
      iPString = IPMath.expandIPv6StringToFullIPv6String(iPString);

      if (!IPMath.isValidIPv6AddressString(iPString)) {
        throw 'IPAddress invalid $iPString (NetworkMask)';
      }
      _iPv6Address = IPv6Address.fromIPv6String(iPString);
    }
    _suffix = suffix;
    _maskIPv6Address =
        IPv6Address.fromSuffix(suffix, isIPv4Address: _isIPv4Address);
    _networkIPv6Address = IPv6Address.toNetwork(_iPv6Address, _maskIPv6Address);
    _broadcastIpv6Address =
        IPv6Address.toBroadcast(_iPv6Address, _maskIPv6Address);
    _minHostIpv6Address = IPv6Address.addToIp(_networkIPv6Address, 1);
    _maxHostIpv6Address = IPv6Address.addToIp(_broadcastIpv6Address, -1);
  }

  late final IPv6Address _iPv6Address;
  late final int _suffix;
  late final IPv6Address _maskIPv6Address;
  late final IPv6Address _networkIPv6Address;
  late final IPv6Address _broadcastIpv6Address;
  late final IPv6Address _minHostIpv6Address;
  late final IPv6Address _maxHostIpv6Address;
  late final bool _isIPv4Address;
  late final bool _showIPOnPrint;

  IPv6Address getIPv6Address() {
    return _iPv6Address;
  }

  int getSuffix() {
    return _suffix;
  }

  IPv6Address getMaskIPv6Address() {
    return _maskIPv6Address;
  }

  IPv6Address getNetworkIPv6Address() {
    return _networkIPv6Address;
  }

  IPv6Address getBroadcastIPv6Address() {
    return _broadcastIpv6Address;
  }

  IPv6Address getMinHostIPv6Address() {
    return _minHostIpv6Address;
  }

  IPv6Address getMaxHostIPv6Address() {
    return _maxHostIpv6Address;
  }

  List<List<String>> printNetworkMask() {
    return <List<String>>[
      if (_showIPOnPrint)
        <String>[
          'IP:',
          if (_isIPv4Address)
            _iPv6Address.getIPv4String()
          else
            _iPv6Address.getIPv6String()
        ],
      <String>['Suffix:', _suffix.toString()],
      <String>[
        'Mask:',
        if (_isIPv4Address)
          _maskIPv6Address.getIPv4String()
        else
          _maskIPv6Address.getIPv6String()
      ],
      <String>[
        'Network:',
        if (_isIPv4Address)
          _networkIPv6Address.getIPv4String()
        else
          _networkIPv6Address.getIPv6String()
      ],
      <String>[
        'Broadcast:',
        if (_isIPv4Address)
          _broadcastIpv6Address.getIPv4String()
        else
          _broadcastIpv6Address.getIPv6String()
      ],
      <String>[
        'min Host:',
        if (_isIPv4Address)
          _minHostIpv6Address.getIPv4String()
        else
          _minHostIpv6Address.getIPv6String()
      ],
      <String>[
        'max Host:',
        if (_isIPv4Address)
          _maxHostIpv6Address.getIPv4String()
        else
          _maxHostIpv6Address.getIPv6String()
      ],
      <String>[
        'count Hosts:',
        IPMath.getCountHostsBySuffix(_suffix, isIPv4Address: _isIPv4Address)
            .toString()
      ]
    ];
  }
}
