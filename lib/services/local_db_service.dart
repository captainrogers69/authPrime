import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseLocalDBService {
  Future<String> getUserName();
  Future<void> setUserName(String username);
}

final localDBProvider = Provider<LocalDBService>((ref) {
  return LocalDBService();
});

class LocalDBService implements BaseLocalDBService {
  static const prefkey = "dataOnDisk";

  @override
  Future<String> getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userNameString = sharedPreferences.getString(prefkey) ?? "Unknown";
    return userNameString;
  }

  @override
  Future<void> setUserName(String username) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(prefkey, username);
  }
}
