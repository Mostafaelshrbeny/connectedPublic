import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiveLocaleData {
  static Box? myAppBox;
  static openbox(String boxname) async {
    myAppBox = await Hive.openBox(boxname);
  }

  static Future<void> deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  static Future<void> deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }
}

class LocalePref {
  static SharedPreferences? prefs;
  static setPref() async {
    prefs = await SharedPreferences.getInstance();
  }
}
