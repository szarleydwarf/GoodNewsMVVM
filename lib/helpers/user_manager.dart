
import 'package:shared_preferences/shared_preferences.dart';

import '../misc/constants.dart';
import '../models/user_model.dart';

class UserManager {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  
  void saveUser(String userName, bool userExist) async {
    final SharedPreferences prefs = await _prefs;

    prefs.setString(nameKey, userName);
    prefs.setBool(userExistKey, userExist);
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await _prefs;
    final name = (prefs.getString(nameKey) ?? friend);
    final isExisting = (prefs.getBool(userExistKey) ?? false);
    return User("id", name, isExisting);
  }

  void deleteUser() async {
    final SharedPreferences prefs = await _prefs;

    prefs.setString(nameKey, emptyString);
    prefs.setBool(userExistKey, false);
  }

}