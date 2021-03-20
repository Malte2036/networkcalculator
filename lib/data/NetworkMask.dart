import 'package:networkcalculator/data/IPv6Address.dart';

class NetworkMask {

  NetworkMask(String iPv6AddressString, int prefix) {
    this._iPv6Address = IPv6Address.fromIPString(iPv6AddressString);
    this._prefix = prefix;
    this._maskIPv6Address = IPv6Address.fromPrefix(prefix);
    this._networkIPv6Address =
        IPv6Address.toNetwork(this._iPv6Address, this._maskIPv6Address);
    this._broadcastIpv6Address =
        IPv6Address.toBroadcast(this._iPv6Address, this._maskIPv6Address);
    this._minHostIpv6Address = IPv6Address.addToIp(this._iPv6Address, 1);
    this._maxHostIpv6Address = IPv6Address.addToIp(this._iPv6Address, -1);
  }

  late final IPv6Address _iPv6Address;
  late final int _prefix;
  late final IPv6Address _maskIPv6Address;
  late final IPv6Address _networkIPv6Address;
  late final IPv6Address _broadcastIpv6Address;
  late final IPv6Address _minHostIpv6Address;
  late final IPv6Address _maxHostIpv6Address;

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
    toPrint += 'IP: ${_iPv6Address.getIPString()} \n';
    toPrint += 'Prefix: ${_prefix.toString()}\n';
    toPrint += 'Mask: ${_maskIPv6Address.getIPString()}\n';
    toPrint += 'Network: ${_networkIPv6Address.getIPString()}\n';
    toPrint += 'Broadcast: ${_broadcastIpv6Address.getIPString()}\n';
    toPrint += 'min Host: ${_minHostIpv6Address.getIPString()}\n';
    toPrint += 'max Host: ${_maxHostIpv6Address.getIPString()}\n';
    return toPrint;
  }
}
