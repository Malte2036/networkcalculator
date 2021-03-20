class IPMath {
  static int iPv6AddressByteCount = 128;
  static int iPv6AddressByteBlockCount = (iPv6AddressByteCount / 16).round();

  static String binaryToIPv6String(String binaryString) {
    int length = binaryString.length;
    String ipString = "";

    int i = 0;
    while (i < IPMath.iPv6AddressByteBlockCount) {
      String addPart = "";
      if (i * 16 < length - 1) {
        int pos = i * 16;
        String binaryPart = binaryString.substring(pos, pos + 16);
        BigInt intPart = binaryToBigInt(binaryPart);
        addPart = bigIntToHex(intPart);
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
      BigInt value = hexToBigInt(element);

      String radixString = bigIntToBinary(value);
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

  static BigInt hexToBigInt(String hex) {
    return BigInt.parse("0x" + hex);
  }

  static BigInt binaryToBigInt(String binary) {
    return BigInt.parse(binary, radix: 2);
  }

  static String bigIntToBinary(BigInt value) {
    return value.toRadixString(2);
  }

  static String bigIntToFullBitBinary(BigInt value) {
    return value.toRadixString(2).padLeft(IPMath.iPv6AddressByteCount, "0");
  }

  static String bigIntToHex(BigInt value) {
    return value.toRadixString(16);
  }

  static List<String> ipStringToArray(String ipString) {
    return ipString.split(":");
  }

  static String expandIPv6StringToFullIPv6String(String ipString){
    int count = ":".allMatches(ipString).length + 1;
    while(count < iPv6AddressByteBlockCount){
      ipString += ":0";
      count++;
    }
    return ipString;
  }

  static bool isValidIPv6AddressString(String iPv6AddressString){
    var ipv6List = ipStringToArray(iPv6AddressString);
    if(ipv6List.any((element) => int.tryParse("0x" + element) == null)){
      return false;
    }
    return true;
  }

  static bool isValidIPv6Prefix(var prefix){
    int? prefixInt = int.tryParse(prefix);
    if(prefixInt == null){
      return false;
    }
    return prefixInt >= 1 && prefixInt <= 128; 
  }
}
