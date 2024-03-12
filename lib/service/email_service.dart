import 'package:flutter/foundation.dart';

class EmailService {
  @protected
  static final EmailService _service = EmailService._instance();
  @protected
  EmailService._instance();

  static EmailService getInstance() => _service;

  bool signIn(String email, String pass) {
    return false;
  }
}
