import 'dart:async';

import 'package:networkcalculator/bloc/data/NetworkMask.dart';

class NetworkMaskBloc {
  final StreamController<NetworkMask?> _networkMaskBySuffixController = StreamController<NetworkMask?>.broadcast();
  final StreamController<NetworkMask?> _networkMaskByTwoAddressController = StreamController<NetworkMask?>.broadcast();

  StreamSink<NetworkMask?> get networkMaskBySuffixSink => _networkMaskBySuffixController.sink;
  Stream<NetworkMask?> get networkMaskBySuffixStream => _networkMaskBySuffixController.stream;

  StreamSink<NetworkMask?> get networkMaskByTwoAddressSink => _networkMaskByTwoAddressController.sink;
  Stream<NetworkMask?> get networkMaskByTwoAddressStream => _networkMaskByTwoAddressController.stream;
}

final NetworkMaskBloc networkMaskBloc = NetworkMaskBloc();