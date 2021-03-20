import 'package:networkcalculator/data/NetworkMask.dart';

mixin NetworkMaskManager {
  static NetworkMask? _currentNetworkMask;

  static NetworkMask? getNetworkMask(){
    return _currentNetworkMask;
  }

  static void setNetworkMask(NetworkMask networkMask){
    _currentNetworkMask = networkMask;
  }
}
