import 'dart:async';

import 'package:networkcalculator/data/NetworkMask.dart';

mixin NetworkMaskManager {
  static StreamController<NetworkMask?> networkMaskBySuffixController = StreamController<NetworkMask?>.broadcast();
  static StreamController<NetworkMask?> networkMaskByTwoAddressController = StreamController<NetworkMask?>.broadcast();
}
