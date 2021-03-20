import 'package:networkcalculator/data/IPv6Address.dart';

class IPMath {
  static int iPv6AddressByteCount = 128;
  static int iPv6AddressByteBlockCount = (iPv6AddressByteCount / 16).round();

  // Regex expression for validating IPv4
  static RegExp iPv4ValidateRegExp = new RegExp(
      "(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])");

  // Regex expression for validating IPv6
  static RegExp iPv6ValidateRegExp =
      new RegExp("((([0-9a-fA-F]){1,4})\\:){7}([0-9a-fA-F]){1,4}");

  static String binaryToIPv6String(String binaryString) {
    int length = binaryString.length;
    String iPv6String = '';

    int i = 0;
    while (i < IPMath.iPv6AddressByteBlockCount) {
      String addPart = '';
      if (i * 16 < length - 1) {
        int pos = i * 16;
        String binaryPart = binaryString.substring(pos, pos + 16);
        BigInt intPart = binaryToBigInt(binaryPart);
        addPart = bigIntToHex(intPart);
      }
      iPv6String += addPart.padLeft(4).replaceAll(' ', '0');
      iPv6String += ':';
      i++;
    }
    iPv6String = iPv6String.substring(0, iPv6String.length - 1);
    return iPv6String.toUpperCase();
  }

  static String iPv6ListToBinary(List<String> iPv6List) {
    String result = '';

    iPv6List.forEach((element) {
      BigInt value = hexToBigInt(element);

      String radixString = bigIntToBinary(value);
      result += radixString.padLeft(16).replaceAll(' ', '0');
    });
    return result;
  }

  static String iPv6ListToString(List<String> iPv6List) {
    String result = '';
    iPv6List.forEach((element) {
      result += element.padLeft(4).replaceAll(' ', '0');
      result += ':';
    });
    return result.substring(0, result.length - 1);
  }

  static String iPv6BinaryToIPv4String(String binaryString) {
    int length = binaryString.length;
    String iPv4String = '';

    int i = 12;
    while (i < 16) {
      String addPart = '';
      if (i * 8 < length - 1) {
        int pos = i * 8;
        String binaryPart = binaryString.substring(pos, pos + 8);
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

    List<String> iPv4List = iPv4String.split(".");

    iPv4List.forEach((element) {
      BigInt value = BigInt.parse(element);

      String radixString = bigIntToBinary(value);
      result += radixString.padLeft(8).replaceAll(' ', '0');
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
    String iPv6Binary = IPMath.iPv4StringToIPv6Binary(iPv4String);
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

  static bool isValidIPv6Prefix(var prefix) {
    int? prefixInt = int.tryParse(prefix);
    if (prefixInt == null) {
      return false;
    }
    return prefixInt >= 1 && prefixInt <= 128;
  }
}
