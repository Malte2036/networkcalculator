import 'package:networkcalculator/data/IPMath.dart';

class IPv6Address {
  IPv6Address(List<String> ipv6List) {
    if (ipv6List.length != IPMath.iPv6AddressByteBlockCount) {
      throw ('Invalid IPv6Address, should have ' +
          IPMath.iPv6AddressByteBlockCount.toString() +
          ' parts');
    }
    this._ipv6List = ipv6List;
  }

  late final List<String> _ipv6List;

  factory IPv6Address.fromIPString(String ipString) {
    if (!IPMath.isValidIPv6AddressString(ipString)) {
      throw ('Invalid IPv6Address');
    }
    ipString = IPMath.expandIPv6StringToFullIPv6String(ipString);
    return new IPv6Address(IPMath.ipStringToArray(ipString));
  }

  factory IPv6Address.fromBinary(String binaryString) {
    String iPv6String = IPMath.binaryToIPv6String(binaryString);
    return IPv6Address.fromIPString(iPv6String);
  }

  factory IPv6Address.fromPrefix(int prefix) {
    String binaryString = ''.padLeft(prefix, '1');
    binaryString = binaryString.padRight(IPMath.iPv6AddressByteCount, '0');

    return IPv6Address.fromBinary(binaryString);
  }

  factory IPv6Address.toNetwork(IPv6Address iPv6Address, IPv6Address mask) {
    String binaryString = '';
    String binaryIPString = iPv6Address.getBinary();
    String binaryMaskString = mask.getBinary();

    for (int i = 0; i < binaryMaskString.length; i++) {
      if ((binaryMaskString[i] == '1') && (binaryIPString[i] == '1')) {
        binaryString += '1';
      } else {
        binaryString += '0';
      }
    }
    return IPv6Address.fromBinary(binaryString);
  }

  factory IPv6Address.toBroadcast(IPv6Address iPv6Address, IPv6Address mask) {
    String binaryString = '';
    String binaryIPString = iPv6Address.getBinary();
    String binaryMaskString = mask.getBinary();

    for (int i = 0; i < binaryMaskString.length; i++) {
      if (binaryMaskString[i] == '0') {
        binaryString += '1';
      } else {
        binaryString += binaryIPString[i];
      }
    }
    return IPv6Address.fromBinary(binaryString);
  }

  factory IPv6Address.addToIp(IPv6Address iPv6Address, int addCount) {
    String binaryString = iPv6Address.getBinary();
    BigInt oldBinaryInt = IPMath.binaryToBigInt(binaryString);

    String newBinary =
        IPMath.bigIntToFullBitBinary(oldBinaryInt + BigInt.from(addCount));
    return IPv6Address.fromBinary(newBinary);
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
