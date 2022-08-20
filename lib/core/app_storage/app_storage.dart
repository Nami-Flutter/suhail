import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soheel_app/core/app_storage/user.dart';

import '../dio_manager/dio_manager.dart';



class AppStorage {

  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> cacheUser(UserModel userModel) async {
    await _preferences.setString('user', json.encode(userModel.toJson()));
  }

  static UserModel? getUserModel() {
    final user = _preferences.getString('user');
    if(user != null)
      return UserModel.fromJson(json.decode(user));
    return null;
  }

  // static bool get isCaptain => getUserModel()?.customerGroup  == 2;
  static int get customerGroup => getUserModel()?.customerGroup ?? 1;

  static int get customerID => getUserModel()?.customerId ?? 1;
  static bool get isLogged => getUserModel() != null;

  static void clearCache() {
    _preferences.remove('user');
  }
}

Future<void> getUserAndCache(int customerID , int customerGroup) async {
  try {
    final response = await DioHelper.post('user/account' ,
      data: {
      'logged': "true",
      'customer_id': customerID,
    });
    final data = response.data as Map<String, dynamic>;
    print(data.toString());
    data.addAll({'customer_id': customerID});
    data.addAll({'customer_group': customerGroup});
    await AppStorage.cacheUser(UserModel.fromJson(data));
    // FirebaseHelper.sendFCM();
  } catch (e) {
    throw e;
  }
}
