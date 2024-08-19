import 'package:hive_flutter/hive_flutter.dart';

class DataManager {
  static late Box sura;

  static const USER = "USER";

  static Future initHive() async {
    await Hive.initFlutter();

    sura = await Hive.openBox('data');
    // final directory = await getApplicationDocumentsDirectory();
    // collection = await BoxCollection.open(
    //   'dataManager', // Name of your database
    //   {'data'}, // Names of your boxes
    //   path: directory
    //       .path, // Path where to store your boxes (Only used in Flutter / Dart IO)
    // );
  }

  static Future<void> saveData(String key, dynamic value) async {
    // await Hive.initFlutter();
    // final box = await Hive.openBox('data');
    await sura.put(key, value);
  }

  static getData(String key) async {
    // await Hive.initFlutter();
    // final box = await Hive.openBox('data');

    return sura.get(key);
  }
}
