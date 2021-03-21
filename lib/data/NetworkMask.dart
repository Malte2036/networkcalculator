import 'package:networkcalculator/data/IPMath.dart';
import 'package:networkcalculator/data/IPv6Address.dart';

class NetworkMask {
  NetworkMask(String iPString, int suffix) {
    _isIPv4Address = IPMath.isValidIPv4AddressString(iPString);
    if (_isIPv4Address) {
      _iPv6Address = IPMath.iPv4StringToIPv6Address(iPString);
    } else {
      iPString = IPMath.expandIPv6StringToFullIPv6String(iPString);

      if (!IPMath.isValidIPv6AddressString(iPString)) {
        throw 'IPAddress invalid';
      }
      _iPv6Address = IPv6Address.fromIPv6String(iPString);
    }
    _suffix = suffix;
    _maskIPv6Address =
        IPv6Address.fromSuffix(suffix, isIPv4Address: _isIPv4Address);
    _networkIPv6Address =
        IPv6Address.toNetwork(_iPv6Address, _maskIPv6Address);
    _broadcastIpv6Address =
        IPv6Address.toBroadcast(_iPv6Address, _maskIPv6Address);
    _minHostIpv6Address = IPv6Address.addToIp(_networkIPv6Address, 1);
    _maxHostIpv6Address =
        IPv6Address.addToIp(_broadcastIpv6Address, -1);
  }

  late final IPv6Address _iPv6Address;
  late final int _suffix;
  late final IPv6Address _maskIPv6Address;
  late final IPv6Address _networkIPv6Address;
  late final IPv6Address _broadcastIpv6Address;
  late final IPv6Address _minHostIpv6Address;
  late final IPv6Address _maxHostIpv6Address;
  late final bool _isIPv4Address;

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

  String printNetworkMask() {
    String toPrint = 'Mask was calculated:\n';
    toPrint +=
        'IP: ${_isIPv4Address ? _iPv6Address.getIPv4String() : _iPv6Address.getIPv6String()} \n';
    toPrint += 'Suffix: ${_suffix.toString()}\n';
    toPrint +=
        'Mask: ${_isIPv4Address ? _maskIPv6Address.getIPv4String() : _maskIPv6Address.getIPv6String()}\n';
    toPrint +=
        'Network: ${_isIPv4Address ? _networkIPv6Address.getIPv4String() : _networkIPv6Address.getIPv6String()}\n';
    toPrint +=
        'Broadcast: ${_isIPv4Address ? _broadcastIpv6Address.getIPv4String() : _broadcastIpv6Address.getIPv6String()}\n';
    toPrint +=
        'min Host: ${_isIPv4Address ? _minHostIpv6Address.getIPv4String() : _minHostIpv6Address.getIPv6String()}\n';
    toPrint +=
        'max Host: ${_isIPv4Address ? _maxHostIpv6Address.getIPv4String() : _maxHostIpv6Address.getIPv6String()}\n';
    return toPrint;
  }
}
