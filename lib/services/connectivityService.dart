import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final _connectivity = Connectivity();
  final connectivityStream = StreamController<ConnectivityResult>()
    ..add(ConnectivityResult.none);
  //ConnectivityResult 값을 출력하는 컨트롤러 생성
  //ConnectivityResult.none으로 초기화

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen((event) {
      connectivityStream.add(event);
    });
  }
}
