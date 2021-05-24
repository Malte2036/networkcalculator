import 'package:networkcalculator/bloc/data/IPv6Address.dart';

class IPMath {
  static int iPv6AddressByteCount = 128;
  static int iPv6AddressByteBlockSize = 16;
  static int iPv6AddressByteBlockCount = (iPv6AddressByteCount / iPv6AddressByteBlockSize).round();

  static int iPv4AddressByteCount = 32;
  static int iPv4AddressByteBlockSize = 8;
  static int iPv4AddressByteBlockCount = (iPv6AddressByteCount / iPv4AddressByteBlockSize).round();

  // Regex expression for validating IPv4
  static RegExp iPv4ValidateRegExp = RegExp(
      '(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])');

  // Regex expression for validating IPv6
  static RegExp iPv6ValidateRegExp =
      RegExp('((([0-9a-fA-F]){1,4})\\:){7}([0-9a-fA-F]){1,4}');

  static String binaryToIPv6String(String binaryString) {
    final int length = binaryString.length;
    String iPv6String = '';

    int i = 0;
    while (i < IPMath.iPv6AddressByteBlockCount) {
      String addPart = '';
      if (i * iPv6AddressByteBlockSize < length - 1) {
        final int pos = i * iPv6AddressByteBlockSize;
        final String binaryPart = binaryString.substring(pos, pos + iPv6AddressByteBlockSize);
        final BigInt intPart = binaryToBigInt(binaryPart);
        addPart = bigIntToHex(intPart);
      }
      iPv6String += addPart.padLeft(4).replaceAll(' ', '0');
      iPv6String += ':';
      i++;
    }
    iPv6String = iPv6String.substring(0, iPv6String.length - 1);
    return iPv6String.toUpperCase();
  }

  static String binaryToIPv4String(String binaryString) {
    final int length = binaryString.length;
    String iPv4String = '';

    int i = 0;
    while (i < 4) {
      String addPart = '';
      if (i * iPv4AddressByteBlockSize < length - 1) {
        final int pos = i * iPv4AddressByteBlockSize;
        final String binaryPart = binaryString.substring(pos, pos + iPv4AddressByteBlockSize);
        addPart = binaryToBigInt(binaryPart).toString();
      }
      iPv4String += addPart;
      iPv4String += '.';
      i++;
    }
    iPv4String = iPv4String.substring(0, iPv4String.length - 1);
    return iPv4String.toUpperCase();
  }

  static String iPv6ListToBinary(List<String> iPv6List) {
    String result = '';

    iPv6List.forEach((String element) {
      final BigInt value = hexToBigInt(element);

      final String radixString = bigIntToBinary(value);
      result += radixString.padLeft(iPv6AddressByteBlockSize).replaceAll(' ', '0');
    });
    return result;
  }

  static String iPv6ListToString(List<String> iPv6List) {
    String result = '';
    iPv6List.forEach((String element) {
      result += element.padLeft(4).replaceAll(' ', '0');
      result += ':';
    });
    return result.substring(0, result.length - 1);
  }

  static String iPv6BinaryToIPv4String(String binaryString) {
    final int length = binaryString.length;
    String iPv4String = '';

    int i = 12;
    while (i < iPv6AddressByteBlockSize) {
      String addPart = '';
      if (i * iPv4AddressByteBlockSize < length - 1) {
        final int pos = i * iPv4AddressByteBlockSize;
        final String binaryPart = binaryString.substring(pos, pos + iPv4AddressByteBlockSize);
        addPart = binaryToBigInt(binaryPart).toString();
      }
      iPv4String += addPart;
      iPv4String += '.';
      i++;
    }
    return iPv4String.substring(0, iPv4String.length - 1);
  }

  static String iPv4StringToIPv6Binary(String iPv4String) {
    String result = '';

    final List<String> iPv4List = iPv4String.split('.');

    iPv4List.forEach((String element) {
      final BigInt value = BigInt.parse(element);

      final String radixString = bigIntToBinary(value);
      result += radixString.padLeft(iPv4AddressByteBlockSize).replaceAll(' ', '0');
    });
    //result = result.padLeft(32).replaceAll(' ', '0');
    //result = result.padLeft(48).replaceAll(' ', '1');
    return result.padLeft(iPv6AddressByteCount).replaceAll(' ', '0');
  }

  static BigInt hexToBigInt(String hex) {
    return BigInt.parse('0x' + hex);
  }

  static BigInt binaryToBigInt(String binary) {
    return BigInt.parse(binary, radix: 2);
  }

  static String binaryPlusBinary(String binary1, String binary2) {
    final BigInt iPv6Address1BigInt = binaryToBigInt(binary1);
    final BigInt iPv6Address2BigInt = binaryToBigInt(binary2);
    return bigIntToBinary(iPv6Address1BigInt + iPv6Address2BigInt).toString();
  }

  static String bigIntToBinary(BigInt value) {
    return value.toRadixString(2);
  }

  static String bigIntToFullBitBinary(BigInt value) {
    return value.toRadixString(2).padLeft(IPMath.iPv6AddressByteCount, '0');
  }

  static String bigIntToHex(BigInt value) {
    return value.toRadixString(16);
  }

  static List<String> iPv6StringToArray(String iPv6String) {
    return iPv6String.split(':');
  }

  static IPv6Address iPv4StringToIPv6Address(String iPv4String) {
    final String iPv6Binary = IPMath.iPv4StringToIPv6Binary(iPv4String);
    return IPv6Address.fromBinary(iPv6Binary, isIPv4Address: true);
  }

  static String expandIPv6StringToFullIPv6String(String iPv6String) {
    int count = ':'.allMatches(iPv6String).length + 1;
    while (count < iPv6AddressByteBlockCount) {
      iPv6String += ':0';
      count++;
    }
    return iPv6String;
  }

  static bool isValidIPv4AddressString(String iPv4AddressString) {
    return iPv4ValidateRegExp.hasMatch(iPv4AddressString);
  }

  static bool isValidIPv6AddressString(String iPv6AddressString) {
    return iPv6ValidateRegExp.hasMatch(iPv6AddressString);
  }

  static bool isValidIPv4Suffix(int suffixInt) {
    return suffixInt >= 1 && suffixInt <= 32;
  }

  static bool isValidIPv6Suffix(int suffixInt) {
    return suffixInt >= 1 && suffixInt <= 128;
  }

  static BigInt getCountHostsBySuffix(int suffix,
      {bool isIPv4Address = false}) {
    final int byteCount =
        isIPv4Address ? iPv4AddressByteCount : iPv6AddressByteCount;
    return BigInt.two.pow(byteCount - suffix) - BigInt.two;
  }

  static int getSmallestSuffixBetweenTwoIPv6Address(
      IPv6Address iPv6AddressFirst, IPv6Address iPv6AddressSecond,
      {bool isIPv4Address = false}) {
    final BigInt iPv6Address1Binary =
        binaryToBigInt(iPv6AddressFirst.getBinary());
    final BigInt iPv6Address2Binary =
        binaryToBigInt(iPv6AddressSecond.getBinary());

    BigInt diff = iPv6Address1Binary - iPv6Address2Binary;
    diff = diff < BigInt.zero ? -diff : diff;
    diff -= BigInt.one;

    final int byteCount =
        isIPv4Address ? iPv4AddressByteCount : iPv6AddressByteCount;
    for (int i = byteCount; i >= 1; i--) {
      final BigInt countHostsBySuffix =
          getCountHostsBySuffix(i, isIPv4Address: isIPv4Address);
      if (countHostsBySuffix >= diff) {
        return i;
      }
    }
    return 0;
  }

  static IPv6Address parseIPv4OrIPv6StringToIPv6Address(String ipString) {
    if (IPMath.isValidIPv4AddressString(ipString)) {
      return IPMath.iPv4StringToIPv6Address(ipString);
    } else {
      ipString = IPMath.expandIPv6StringToFullIPv6String(ipString);
      return IPv6Address.fromIPv6String(ipString);
    }
  }
}
