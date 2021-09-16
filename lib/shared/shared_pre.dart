
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static SharedPreferences myshared;

  static init() async {
    myshared = await SharedPreferences.getInstance();
  }

  static Future<bool> setData(
      {@required String key, @required dynamic value}) async {
    if (value is String) return await myshared.setString(key, value);
    if (value is bool) return await myshared.setBool(key, value);
    if (value is double) return await myshared.setDouble(key, value);
    return await myshared.setInt(key, value);
  }

  static dynamic getData({@required String key}) {
    return myshared.get(key);
  }

  static void romoveData ({@required String key}){

        myshared.remove(key) ;

  }


}
