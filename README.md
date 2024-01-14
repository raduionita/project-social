### social prototype

### setup
```shell
flutter doctor
flutter clean
flutter pub get
flutter pub upgrade --major-versions
```

### build runner
```shell
flutter pub run build_runner build
```


### build splash screen
```shell
flutter pub run flutter_native_splash:create --flavor work
flutter pub run flutter_native_splash:create --flavor live
```



### useful packages
- https://pub.dev/packages/flutter_native_splash
- cupertino_icons: ^1.0.2
- flutter_hooks: ^0.18.5+1
- provider: ^6.0.4
- super_annotations: ^0.7.1
- flutter_secure_storage: ^4.2.1

- json_annotation

- json_serializable
- build_runner


- cached_network_image
- flutter_local_notifications
- url_launcher
- shared_preferences // flutter_secure_storage
- webview_flutter
- fluttertoast
- json_annotation
- geolocator
- share_plus
- device_info_plus
- crypto
- flutter_native_splash
- http

### assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).

### localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)
