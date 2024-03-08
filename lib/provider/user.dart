import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_social/model/user.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  //FlutterSecureStorage storage = const FlutterSecureStorage();

  UserModel _data = UserModel();

  UserModel get data => _data;

  set data(UserModel value) {
    _data = value;
    notifyListeners();
  }

  static UserProvider from(BuildContext context) {
    return Provider.of(context);
  }

  Future<UserModel?> getUser() async {
    //String? json; //  = await storage.read(key: "user");
    //return null;
    return UserModel();
  }
}
