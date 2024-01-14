import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_social/stores/user.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  //FlutterSecureStorage storage = const FlutterSecureStorage();

  UserStore _data = UserStore();

  UserStore get data => _data;

  set data(UserStore value) {
    _data = value;
    notifyListeners();
  }

  static UserProvider from(BuildContext context) {
    return Provider.of(context);
  }

  Future<UserStore?> getUser() async {
    //String? json; //  = await storage.read(key: "user");
    //return null;
    return UserStore();
  }
}
