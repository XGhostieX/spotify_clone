import 'package:flutter/foundation.dart';

class Constants {
  static String serverURL = kIsWeb ? 'http://127.0.0.1:8000' : 'http://192.168.1.5:8000';
  // static String serverURL = Platform.isAndroid ? 'http://192.168.1.1:8000' : 'http://127.0.0.1:8000';
  // static String serverURL = 'http://127.0.0.1:8000';
}
