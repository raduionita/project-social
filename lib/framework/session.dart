import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Session extends ChangeNotifier {
  // + bool isOnboard
  // + bool isAuth
  // + Model user/profile
  // + JSON config/settings

  static Session of(BuildContext context, {bool listen = true}) {
    return Provider.of<Session>(context, listen: listen);
  }

  /// ack the changes & notifies listeners
  void commit() {
    notifyListeners();
  }

  Future auth() async {
    try {

    } catch (e) {
      notifyListeners();
      return false;
    }
  }

  /// logout/signout
  Future exit() async {
    // _auth.signOut();
    // _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
