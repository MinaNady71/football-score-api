import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{

  static late  SharedPreferences sharedPreferences;
static init()async{
   sharedPreferences = await SharedPreferences.getInstance();
 }
static Future<bool> putBoolean({
  required String key,
  required bool value
})async{
return await sharedPreferences.setBool(key, value);
}

static dynamic getBoolData(String key){
return sharedPreferences.getBool(key);
}

  static Future<bool> putDouble({
    required String key,
    required double value
  })async{

    return await sharedPreferences.setDouble(key, value);
  }

  static dynamic getDoubleData(String key){
    return sharedPreferences.getDouble(key);
  }

  static Future<bool> putList({
    required String key,
    required List<String> value
  })async{

    return await sharedPreferences.setStringList(key, value);
  }

  static dynamic getList(String key){
    return sharedPreferences.getStringList(key);
  }

}