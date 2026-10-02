import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectivityStatus { online, offline }

final connectivityStatusProvider = StreamProvider<ConnectivityStatus>((ref) {
  final controller = StreamController<ConnectivityStatus>();
  final connectivity = Connectivity();

  connectivity.checkConnectivity().then((result) {
    controller.add(result != ConnectivityResult.none
        ? ConnectivityStatus.online
        : ConnectivityStatus.offline);
  });

  final sub = connectivity.onConnectivityChanged.listen((result) {
    controller.add(result != ConnectivityResult.none
        ? ConnectivityStatus.online
        : ConnectivityStatus.offline);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
