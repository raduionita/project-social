import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const String IS_AUTH = "isAuth";
// ignore: constant_identifier_names
const String IS_ONBOARD = "isOnboard";

/// session = app-level context
class Session extends ChangeNotifier {
  @protected
  final SharedPreferences shared;

  late bool isOnboard;
  late bool isAuth;
  // + Model user/profile
  // + JSON config/settings

  Session({required this.shared})
      : isOnboard = shared.getBool(IS_ONBOARD) ?? false,
        isAuth = shared.getBool(IS_AUTH) ?? false;

  static Session of(BuildContext context) {
    return Provider.of<Session>(context, listen: false);
  }

  static Session read(BuildContext context) {
    return context.read<Session>();
  }

  static Session watch(BuildContext context) {
    return context.watch<Session>();
  }

  void onOnBoard() {
    isOnboard = true;
    shared.setBool(IS_ONBOARD, true);
    notifyListeners();
  }

  void onAuth() {
    isAuth = true;
    shared.setBool(IS_AUTH, true);
    notifyListeners();
  }

  /// ack the changes & notifies listeners
  void commit() {
    shared.setBool(IS_ONBOARD, isOnboard);
    notifyListeners();
  }

  void clear() {
    isOnboard = false;
    isAuth = false;
    shared.clear();
    notifyListeners();
  }
}
