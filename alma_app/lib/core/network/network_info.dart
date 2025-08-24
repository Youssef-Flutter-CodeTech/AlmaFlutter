import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class InternetConnectivity {
  Future<bool> get isConnected;
}

class NetworkInfo implements InternetConnectivity {
  static final NetworkInfo _instance = NetworkInfo._internal();
  Connectivity _connectivity;
  StreamController<ConnectivityResult>? _connectivityStreamController;

  factory NetworkInfo({
    Connectivity? connectivity,
  }) {
    return _instance.._connectivity = connectivity ?? Connectivity();
  }

  NetworkInfo._internal() : _connectivity = Connectivity();

  void init() {
    _connectivityStreamController =
        StreamController<ConnectivityResult>.broadcast();
    _connectivity.onConnectivityChanged.listen((result) {
      _connectivityStreamController?.add(result.last);
    });
  }

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return result.last != ConnectivityResult.none;
  }

  Future<ConnectivityResult> getCurrentStatus() async {
    final res = await _connectivity.checkConnectivity();
    return res.last;
  }

  Stream<ConnectivityResult> get connectivityStream {
    if (_connectivityStreamController == null) {
      throw Exception('NetworkInfo not initialized. Call init() first.');
    }
    return _connectivityStreamController!.stream;
  }

  void dispose() {
    _connectivityStreamController?.close();
    _connectivityStreamController = null;
  }
}
