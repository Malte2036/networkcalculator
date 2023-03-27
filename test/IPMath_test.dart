import 'package:flutter_test/flutter_test.dart';
import 'package:networkcalculator/bloc/data/IPMath.dart';

void main() {
  test('Test binaryToIPv6String', () {
    const String binary =
        '00000000000000000101110000100101010001101100101101010110010110010000000000000000000000000000000011111111111111110000000000000001';

    expect(IPMath.binaryToIPv6String(binary),
        '0000:5C25:46CB:5659:0000:0000:FFFF:0001');
  });

  test('Test binaryToIPv4String', () {
    const String binary = '11000000101010001011001001100100';

    expect(IPMath.binaryToIPv4String(binary), '192.168.178.100');
  });

  test('test iPv6ListToBinary', () {
    final List<String> iPv6List = <String>[
      '01EF',
      'FF00',
      'FAB2',
      '650F',
      '0000',
      '0000',
      '192E',
      'FF3F'
    ];

    expect(IPMath.iPv6ListToBinary(iPv6List),
        '00000001111011111111111100000000111110101011001001100101000011110000000000000000000000000000000000011001001011101111111100111111');
  });

  test('test getCountHostsBySuffix iPv4', () {
    expect(IPMath.getCountHostsBySuffix(12, isIPv4Address: true),
        BigInt.from(1048574));
  });

  test('test getCountHostsBySuffix iPv6', () {
    expect(IPMath.getCountHostsBySuffix(90), BigInt.from(274877906942));
  });

  test('test expandIPv6StringToFullIPv6String', () {
    expect(IPMath.expandIPv6StringToFullIPv6String("21F:FFA1:::21:322:"),
        "021F:FFA1:0000:0000:0021:0322:0000:0000");
  });

  test('test expandIPv6StringToFullIPv6String trailing', () {
    expect(IPMath.expandIPv6StringToFullIPv6String("12:12:12:::"),
        "0012:0012:0012:0000:0000:0000:0000:0000");
  });
}
