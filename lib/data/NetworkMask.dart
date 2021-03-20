import 'package:networkcalculator/data/IPMath.dart';
import 'package:networkcalculator/data/IPv6Address.dart';

class NetworkMask {
  NetworkMask(String iPString, int prefix) {
    _isIPv4Address = !IPMath.isValidIPv6AddressString(iPString);
    if (_isIPv4Address) {
      if (!IPMath.isValidIPv4AddressString(iPString)) {
        throw ("IPAddress invalid");
      }
      this._iPv6Address = IPMath.iPv4StringToIPv6Address(iPString);
    } else {
      this._iPv6Address = IPv6Address.fromIPv6String(iPString);
    }
    this._prefix = prefix;
    this._maskIPv6Address =
        IPv6Address.fromPrefix(prefix, isIPv4Address: _isIPv4Address);
    this._networkIPv6Address =
        IPv6Address.toNetwork(this._iPv6Address, this._maskIPv6Address);
    this._broadcastIpv6Address =
        IPv6Address.toBroadcast(this._iPv6Address, this._maskIPv6Address);
    this._minHostIpv6Address = IPv6Address.addToIp(this._networkIPv6Address, 1);
    this._maxHostIpv6Address = IPv6Address.addToIp(this._broadcastIpv6Address, -1);
  }

  late final IPv6Address _iPv6Address;
  late final int _prefix;
  late final IPv6Address _maskIPv6Address;
  late final IPv6Address _networkIPv6Address;
  late final IPv6Address _broadcastIpv6Address;
  late final IPv6Address _minHostIpv6Address;
  late final IPv6Address _maxHostIpv6Address;
  late final bool _isIPv4Address;

  IPv6Address getIPv6Address() {
    return _iPv6Address;
  }

  int getPrefix() {
    return _prefix;
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
    toPrint += 'Prefix: ${_prefix.toString()}\n';
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
