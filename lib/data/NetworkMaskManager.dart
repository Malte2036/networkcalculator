import 'dart:async';

import 'package:networkcalculator/data/NetworkMask.dart';

mixin NetworkMaskManager {
  static StreamController<NetworkMask> networkMaskController = StreamController<NetworkMask>();
}
