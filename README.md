# Project:Social

## features
```
+ logic
  + send likes in bulk (after 10 or 20 likes)

+ init
  + onboarding
+ auth
  + sign view
    + buttons (google, apple, facebook) 
  + create view
    + profile data form (country + city + birthdate + gender)
    + profile images
  + providers
    + google
    + apple
    + facebook
    + firebase? (pass + email = hash)
+ home
  + swipper
    + load data from database
  + chatter
    + view 
    + load from database
    + data (realtime: /relations/relationId/messages/messageId)
      / messageId 20240124120359 (YYYYMMDDHHMMSS) 
        + message: string
        + flags:   int     (or seen:bool)
        + sender:  string  ("0001")
  + profile (user)
    + view
    + query: SELECT * FROM users WHERE country = ? AND city = ? AND gender IN ['F','M'] AND birthyear IN [1986] and created > "20240116"
    + data (firestore: /users/8r6yfrXk1rF3HkaX1OB7)
      - bio: string
      - birthdate: string   (MMDD)
      - birthyear: string   (YYYY)
      - city: string        (Bucharest)
      - country: string     (ISO3) (ROU)
      - gender: string      (M|F|T|N|O)
      - images: []string    (["site.com/path/to/image.png"]) (link w/o https)
      - interests: []string (["dogs","coding"])
      - name: string
      - updated: string     (YYYYMMDD=20240105)
      - created: string     (YYMMDDHH=23123117) (year='23, 31th December at 17:00)
  + favorit (relations, likes)
    + view
    + data (realtime: /matches)
      / relations
        / relationId (0001x0002) (id from user ids, smaller first)
          + created: string (YYYYMMDD)
          + type   : int    (1 = 1st liked, 2 = 2nd liked, 3 = both liked)
          / messages: object

```
## backend
```
+ firebase
    project_name: project-social
    project_id: project-social-3c0f3
    project_number: 922702762472
  resources
    + functions (api calls)
    + storage (images)
    + authentication 
    + firestore (user data)
    + realtime (chats)
```
---
---
# Flutter
## setup
```
flutter doctor
flutter clean
flutter pub get
flutter pub upgrade --major-versions
```
## features
```
- Expanded (as child of Column, Row or Flex) = expands this element & shrinks the siblings
- FirebaseAnimatedList = Firebase + ListView
- StreamBuilder
- FutureBuilder
- VisibilityDetector
- SmartRefresh + WaterDropHeader = android style drop to refresh
```
## packages
```

```



## build runner
```shell
flutter pub run build_runner build
```

## build splash screen
```shell
flutter pub run flutter_native_splash:create --flavor env?
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
