import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:project_social/model/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const String IS_AUTH = "isAuth";
// ignore: constant_identifier_names
const String IS_ONBOARD = "isOnboard";

class Session extends ChangeNotifier {
  // data
  late bool isOnboard = false;
  late bool isAuth = false;
  late UserModel user;

  @protected
  late SharedPreferences shared;

  Session._internal();

  factory Session() => instance;

  static final instance = Session._internal();

  static initialize() async {
    instance.shared = await SharedPreferences.getInstance();

    instance.isOnboard = instance.shared.getBool(IS_ONBOARD) ?? false;
    instance.isAuth = instance.shared.getBool(IS_AUTH) ?? false;

    UserModel.fromJson(jsonDecode(instance.shared.getString("user") ?? '{"id":"n/a"}'));
  }

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
