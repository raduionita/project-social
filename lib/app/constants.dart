import 'package:flutter/foundation.dart';

const double kLogoWidth = 128;
const double kLogoHeight = 128;

const int kFirebaseFunctionsEmulatorPort = 5001;
const int kFirebaseFirestoreEmulatorPort = 8080;
const int kFirebaseDatabaseEmulatorPort = 9000;
const int kFirebaseStorageEmulatorPort = 9199;
const int kFirebasePubSubEmulatorPort = 8085;

final String kFirebaseEmulatorHost = !kIsWeb && defaultTargetPlatform == TargetPlatform.android ? '10.0.2.2' : 'localhost';

const String kEnv = String.fromEnvironment("APP_ENV");
