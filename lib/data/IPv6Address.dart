import 'package:netzwerkrechner/data/IPMath.dart';

class IPv6Address {
  IPv6Address(List<String> ipv6List) {
    if (ipv6List.length != 3) {
      throw ("Invalid IPv6Address, should have 3 parts");
    }
    this._ipv6List = ipv6List;
  }

  late final List<String> _ipv6List;

  factory IPv6Address.fromIPString(String ipString) {
    return new IPv6Address(ipStringToArray(ipString));
  }

  factory IPv6Address.fromBinary(String binaryString) {
    String iPv6String = IPMath.binaryToIPv6String(binaryString);
    return IPv6Address.fromIPString(iPv6String);
  }

  factory IPv6Address.fromPrefix(int prefix) {
    String binaryString = "".padLeft(prefix, "1");
    binaryString = binaryString.padRight(48, "0");

    return IPv6Address.fromBinary(binaryString);
  }

  factory IPv6Address.toNetwork(IPv6Address iPv6Address, IPv6Address mask) {
    String binaryString = "";
    String binaryIPString = iPv6Address.getBinary();
    String binaryMaskString = mask.getBinary();

    for (int i = 0; i < binaryMaskString.length; i++) {
      if ((binaryMaskString[i] == '1') && (binaryIPString[i] == '1')) {
        binaryString += "1";
      } else {
        binaryString += "0";
      }
    }
    return IPv6Address.fromBinary(binaryString);
  }

  factory IPv6Address.toBroadcast(IPv6Address iPv6Address, IPv6Address mask) {
    String binaryString = "";
    String binaryIPString = iPv6Address.getBinary();
    String binaryMaskString = mask.getBinary();

    for (int i = 0; i < binaryMaskString.length; i++) {
      if (binaryMaskString[i] == '0') {
        binaryString += "1";
      } else {
        binaryString += binaryIPString[i];
      }
    }
    return IPv6Address.fromBinary(binaryString);
  }

  factory IPv6Address.addToIp(IPv6Address iPv6Address, int addCount){
    String binaryString = iPv6Address.getBinary();
    int oldBinaryInt = IPMath.binaryToInt(binaryString);
    
    String newBinary = IPMath.intTo48BitBinary(oldBinaryInt + addCount);
    return IPv6Address.fromBinary(newBinary);
  }

  static List<String> ipStringToArray(String ipString) {
    return ipString.split(":");
  }

  List<String> getIPList() {
    return _ipv6List;
  }

  String getIPString() {
    return IPMath.ipv6ListToString(_ipv6List);
  }

  String getBinary() {
    return IPMath.ipv6ListToBinary(getIPList());
  }
}
