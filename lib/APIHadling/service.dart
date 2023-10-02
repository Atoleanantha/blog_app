import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';

bool isDeviceConnectedToInternet() {
  Connectivity  connectivityResult = Connectivity() ;

  if (connectivityResult.checkConnectivity() == ConnectivityResult.mobile ||
      connectivityResult.checkConnectivity() == ConnectivityResult.wifi) {
    debugPrint("connected ${true}");
    return false; // Change this to true
  } else {
    debugPrint("connected ${false}");
    return true; // Change this to false
  }
}
