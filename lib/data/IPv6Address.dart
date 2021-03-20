import 'package:networkcalculator/data/IPMath.dart';

class IPv6Address {
  IPv6Address(List<String> iPv6List, {bool isIPv4Address: false}) {
    if (iPv6List.length != IPMath.iPv6AddressByteBlockCount) {
      throw ('Invalid IPv6Address, should have ' +
          IPMath.iPv6AddressByteBlockCount.toString() +
          ' parts');
    }
    this._iPv6List = iPv6List;
    this._isIPv4Address = isIPv4Address;
  }

  late final List<String> _iPv6List;
  late final bool _isIPv4Address;

  factory IPv6Address.fromIPv6String(String iPv6String,
      {bool isIPv4Address: false}) {
    if (!IPMath.isValidIPv6AddressString(iPv6String)) {
      throw ('Invalid IPv6Address');
    }
    iPv6String = IPMath.expandIPv6StringToFullIPv6String(iPv6String);
    return new IPv6Address(IPMath.iPv6StringToArray(iPv6String),
        isIPv4Address: isIPv4Address);
  }

  factory IPv6Address.fromBinary(String binaryString,
      {bool isIPv4Address: false}) {
    String iPv6String = IPMath.binaryToIPv6String(binaryString);
    return IPv6Address.fromIPv6String(iPv6String, isIPv4Address: isIPv4Address);
  }

  factory IPv6Address.fromPrefix(int prefix, {bool isIPv4Address: false}) {
    String binaryString = '';
    if (isIPv4Address) {
      binaryString = binaryString.padRight(prefix + 96, '1');
    } else {
      binaryString = binaryString.padRight(prefix, '1');
    }
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

  bool isIPv4Address() {
    return _isIPv4Address;
  }

  List<String> getIPv6List() {
    return _iPv6List;
  }

  String getIPv6String() {
    return IPMath.iPv6ListToString(_iPv6List);
  }

  String getIPv4String() {
    var binaryString = IPMath.iPv6ListToBinary(_iPv6List);
    return IPMath.iPv6BinaryToIPv4String(binaryString);
  }

  String getBinary() {
    return IPMath.iPv6ListToBinary(getIPv6List());
  }
}
