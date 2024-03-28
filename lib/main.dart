// flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// dependencies
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
// app
import 'package:project_social/app/app.dart';
import 'package:project_social/app/constants.dart';
import 'package:project_social/app/session.dart';
import 'package:project_social/app/config.dart';

void main() async {
  // setup
  WidgetsFlutterBinding.ensureInitialized();
  // chrome
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // firebase
  await Firebase.initializeApp(options: FirebaseConfig.currentPlatform);
  // emulators
  await FirebaseStorage.instance.useStorageEmulator(kFirebaseEmulatorHost, kFirebaseStorageEmulatorPort);
  FirebaseFirestore.instance.useFirestoreEmulator(kFirebaseEmulatorHost, kFirebaseFirestoreEmulatorPort);

  // error
  // FlutterError.onError = (details) {
  //   print("FlutterError.onError()");
  //   FlutterError.dumpErrorToConsole(details);
  //   runApp(MaterialApp(home: OupsScreen(details)));´
  // };
  // ErrorWidget.builder = (details) {
  //   print("ErrorWidget.builder()");
  //   FlutterError.dumpErrorToConsole(details);
  //   return MaterialApp(home: OupsScreen(details));
  // };
  // start

  // singletons
  await Session.initialize();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => kEnv),
        //ChangeNotifierProvider(create: (context) => Manager()), // Manager : ChangeNotifier = service w/ dependency graph
        ChangeNotifierProvider(create: (context) => Session()),
      ],
      child: const App(key: Key('App')),
    ),
  );
}
