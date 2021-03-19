class IPMath {
  static String binaryToIPv6String(String binaryString) {
    int length = binaryString.length;
    String ipString = "";

    int i = 0;
    while (i < 3) {
      String addPart = "";
      if (i * 16 < length - 1) {
        int pos = i * 16;
        String binaryPart = binaryString.substring(pos, pos + 16);
        int intPart = binaryToInt(binaryPart);
        addPart = intToHex(intPart);
      }
      ipString += addPart.padLeft(4).replaceAll(" ", "0");
      ipString += ":";
      i++;
    }
    ipString = ipString.substring(0, ipString.length - 1);
    return ipString.toUpperCase();
  }

  static String ipv6ListToBinary(List<String> ipv6List) {
    String result = "";

    ipv6List.forEach((element) {
      int value = hexToInt(element);

      String radixString = intToBinary(value);
      result += radixString.padLeft(16).replaceAll(" ", "0");
    });
    return result;
  }

  static String ipv6ListToString(List<String> ipv6List) {
    String result = "";
    ipv6List.forEach((element) {
      result += element.padLeft(4).replaceAll(" ", "0");
      result += ":";
    });
    return result.substring(0, result.length - 1);
  }

  static int hexToInt(String hex) {
    return int.parse("0x" + hex);
  }

  static int binaryToInt(String binary) {
    return int.parse(binary, radix: 2);
  }

  static String intToBinary(int value) {
    return value.toRadixString(2);
  }

  static String intTo48BitBinary(int value) {
    return value.toRadixString(2).padLeft(48, "0");
  }

  static String intToHex(int value) {
    return value.toRadixString(16);
  }
}
