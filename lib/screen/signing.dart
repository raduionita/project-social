// dart
import 'dart:io';
// flutter
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
// packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
// app
import 'package:project_social/app/assets.dart';
import 'package:project_social/app/extensions.dart';
import 'package:project_social/app/session.dart';
// widgets
import 'package:project_social/widget/async_builder.dart';
import 'package:project_social/widget/async_list.dart';
import 'package:project_social/widget/birthdate_picker.dart';
import 'package:project_social/widget/country_picker.dart';
import 'package:project_social/widget/custom_logo.dart';
import 'package:project_social/widget/gender_picker.dart';
import 'package:project_social/widget/image_cropper.dart';
import 'package:project_social/widget/interests_picker.dart';
import 'package:project_social/widget/picture_picker.dart';
import 'package:project_social/widget/shape_avatar.dart';
import 'package:project_social/widget/signin_button.dart';
import 'package:project_social/widget/wrapper.dart';

// ignore: must_be_immutable
class SigningScreen extends HookWidget {
  const SigningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('SigningScreen::build(${Provider.of<String>(context)})');

    final pager = usePageController(initialPage: 2, keepPage: true);

    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pager,
        children: [
          SigningPage(onDone: () => pager.animateToPage(1, duration: const Duration(milliseconds: 250), curve: Curves.linear)), //0
          DetailsPage(onDone: () => pager.animateToPage(2, duration: const Duration(milliseconds: 250), curve: Curves.linear)), //1
          PicturePage(onDone: () => pager.animateToPage(3, duration: const Duration(milliseconds: 250), curve: Curves.linear)), //2
          WelcomePage(onDone: () => GoRouter.of(context).go('/')), //3
        ],
      ),
    );
  }
}

class SigningPage extends StatelessWidget {
  const SigningPage({super.key, this.onDone});

  final VoidCallback? onDone;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(flex: 5, child: Container(alignment: Alignment.bottomCenter, color: Colors.black, child: const CustomLogo())),
          const Spacer(flex: 1),
          Flexible(
              flex: 9,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: SignInButton(
                        icon: const Icon(IconFont.google, size: 16),
                        label: const Text("Sign-in with Google"),
                        onPressed: () async {
                          Session.of(context).clear();
                          GoRouter.of(context).go('/');
                          // done
                          onDone!();
                        },
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: SignInButton(
                        icon: const Icon(IconFont.apple, size: 18),
                        label: const Text("Sign-in with Apple"),
                        onPressed: () {
                          // done
                          onDone!();
                        },
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: SignInButton(
                        icon: const Icon(IconFont.facebook, size: 18),
                        label: const Text("Sign-in with Facebook"),
                        onPressed: () {
                          // done
                          onDone!();
                        },
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: SignInButton(
                        icon: const Icon(Icons.phone_enabled_rounded, size: 19),
                        label: const Text("Sign-in with Phone"),
                        onPressed: () {
                          // done
                          onDone!();
                        },
                      )),
                ],
              )),
        ],
      );
}

class DetailsPage extends HookWidget {
  const DetailsPage({super.key, this.onDone});

  final VoidCallback? onDone;

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final now = DateTime.now();
    final last = DateTime(now.year - 18, now.month, now.day);

    final pager = usePageController(initialPage: 4, keepPage: true);

    final name = useState("");
    final birthdate = useState(last.toDate());
    final country = useState("");
    final gender = useState("");
    final interests = useState<List<String>>([]);

    return Form(
      key: formKey,
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pager,
        children: [
          // name
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Flexible(
                  flex: 6,
                  child: TextFormField(
                    initialValue: name.value,
                    autofocus: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(hintText: "Enter your name", helperText: ' ', border: InputBorder.none),
                    validator: (value) => value == null || value.isEmpty ? 'Not a valid name' : null,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => name.value = value,
                    onFieldSubmitted: (value) => print("name.onFieldSubmitted($value)"),
                    onEditingComplete: () => name.value.isNotEmpty ? pager.animateToPage(1, duration: const Duration(milliseconds: 250), curve: Curves.linear) : null,
                  )),
              Flexible(
                  child: Visibility(
                      visible: name.value.isNotEmpty,
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 18),
                          child:
                              IconButton(onPressed: () => pager.animateToPage(1, duration: const Duration(milliseconds: 250), curve: Curves.linear), icon: const Icon(Icons.navigate_next_outlined)))))
            ],
          )),

          // birthday
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 18),
                      child: IconButton(onPressed: () => pager.animateToPage(0, duration: const Duration(milliseconds: 250), curve: Curves.linear), icon: const Icon(Icons.navigate_before_outlined)))),
              Flexible(
                flex: 6,
                child: Wrapper(
                  onBuild: () async => birthdate.value = (await showBirthDatePicker(context: context, initialDate: DateTime.parse(birthdate.value))).toDate(),
                  builder: () => TextFormField(
                    controller: TextEditingController(text: birthdate.value),
                    readOnly: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.none,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(hintText: "Enter your birth date", helperText: ' ', border: InputBorder.none),
                    validator: (value) => value == null || value.isEmpty || value == '0000-00-00' ? 'Not a valid birth day' : null,
                    onTap: () async => birthdate.value = (await showBirthDatePicker(context: context, initialDate: DateTime.parse(birthdate.value))).toDate(),
                    onChanged: (value) => name.value = value,
                    onFieldSubmitted: (value) => print("birthdate.onFieldSubmitted($value)"),
                    //onEditingComplete: () => pager.animateToPage(2, duration: const Duration(milliseconds: 250), curve: Curves.linear),
                  ),
                ),
              ),
              Flexible(
                  child: Visibility(
                      visible: birthdate.value.length == "1900-01-01".length,
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 18),
                          child:
                              IconButton(onPressed: () => pager.animateToPage(2, duration: const Duration(milliseconds: 250), curve: Curves.linear), icon: const Icon(Icons.navigate_next_outlined)))))
            ],
          )),

          // country
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 18),
                      child: IconButton(onPressed: () => pager.animateToPage(1, duration: const Duration(milliseconds: 250), curve: Curves.linear), icon: const Icon(Icons.navigate_before_outlined)))),
              Flexible(
                  flex: 6,
                  child: Wrapper(
                    onBuild: () async => country.value = (await showCountryPicker(context: context)).name,
                    builder: () => TextFormField(
                      controller: TextEditingController(text: country.value),
                      readOnly: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.none,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(hintText: "Select your country", helperText: ' ', border: InputBorder.none),
                      validator: (value) => value == null || value.isEmpty ? 'Not a valid country' : null,
                      onTap: () async => country.value = (await showCountryPicker(context: context)).name,
                      onFieldSubmitted: (value) => print("country.onFieldSubmitted($value)"),
                      // onEditingComplete: () => pager.animateToPage(3, duration: const Duration(milliseconds: 250), curve: Curves.linear),
                    ),
                  )),
              Flexible(
                  child: Visibility(
                      visible: country.value.length > 1,
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 18),
                          child:
                              IconButton(onPressed: () => pager.animateToPage(3, duration: const Duration(milliseconds: 250), curve: Curves.linear), icon: const Icon(Icons.navigate_next_outlined)))))
            ],
          )),

// TODO: city

          // gender
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 18),
                      child: IconButton(onPressed: () => pager.animateToPage(2, duration: const Duration(milliseconds: 250), curve: Curves.linear), icon: const Icon(Icons.navigate_before_outlined)))),
              Flexible(
                  flex: 6,
                  child: Wrapper(
                    onBuild: () async => gender.value = (await showGenderPicker(context: context, title: "Select your gender")).name,
                    builder: () => TextFormField(
                      controller: TextEditingController(text: gender.value),
                      readOnly: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.none,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(hintText: "Select your gender", helperText: ' ', border: InputBorder.none),
                      validator: (value) => value == null || value.isEmpty ? 'Not a valid option' : null,
                      onTap: () async => gender.value = (await showGenderPicker(context: context, title: "Select your gender")).name,
                      onFieldSubmitted: (value) => print("gender.onFieldSubmitted($value)"),
                    ),
                  )),
              Flexible(
                  child: Visibility(
                      visible: gender.value.isNotEmpty,
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 18),
                          child:
                              IconButton(onPressed: () => pager.animateToPage(4, duration: const Duration(milliseconds: 250), curve: Curves.linear), icon: const Icon(Icons.navigate_next_outlined)))))
            ],
          )),

          // interests
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 18),
                      child: IconButton(onPressed: () => pager.animateToPage(3, duration: const Duration(milliseconds: 250), curve: Curves.linear), icon: const Icon(Icons.navigate_before_outlined)))),
              Flexible(
                  flex: 6,
                  child: Wrapper(
                    onBuild: () async => interests.value = (await showInterestsPicker(context: context, title: "Select your interests", inital: interests.value)) ?? [],
                    builder: () => TextFormField(
                      controller: TextEditingController(text: interests.value.join(", ")),
                      maxLines: null,
                      readOnly: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.none,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(hintText: "Select some interests", helperText: ' ', border: InputBorder.none),
                      validator: (value) => value == null || value.isEmpty ? 'Not a valid interest' : null,
                      onTap: () async => interests.value = (await showInterestsPicker(context: context, title: "Select your interests", inital: interests.value)) ?? [],
                      onFieldSubmitted: (value) => print("interests.onFieldSubmitted($value)"),
                    ),
                  )),
              Flexible(
                child: Visibility(
                    visible: true,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 18),
                      child: IconButton(onPressed: () => onDone!(), icon: const Icon(Icons.done)),
                    )),
              )
            ],
          ))
        ],
      ),
    );
  }
}

class PicturePage extends HookWidget {
  const PicturePage({super.key, this.onDone});

  final VoidCallback? onDone;

  void doPicker(ValueNotifier<XFile?> image, ValueNotifier<CroppedFile?> cropp, ImageSource source) async {
    // open picker
    image.value = (await showPicturePicker(source)).image;
    // open cropper
    cropp.value = (await showImageCropper(image.value!.path)).image;
  }

  // TODO: load lost data // see image_picker
  Future<void> prepare() async {
    if (defaultTargetPlatform == TargetPlatform.android) {}
    return;
  }

  @override
  Widget build(BuildContext context) {
    final image = useState<XFile?>(null);
    final cropp = useState<CroppedFile?>(null);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        titleTextStyle: const TextStyle(fontSize: 18),
        backgroundColor: Colors.transparent,
        title: Visibility(visible: cropp.value == null, child: const Text("Add your profile picture")),
      ),
      body: Center(
          child: FutureBuilder<void>(
        future: prepare(),
        builder: (context, snapshot) => switch (snapshot.connectionState) {
          ConnectionState.none || ConnectionState.waiting => const CircularProgressIndicator(),
          ConnectionState.active => snapshot.hasError ? const Text("pick error") : const Text("no image"),
          ConnectionState.done => image.value == null
              // ? Container(
              //     width: double.infinity,
              //     height: double.infinity,
              //     decoration: BoxDecoration(image: DecorationImage(image: Image.asset("asset/image/placeholder.png").image)),
              //     margin: const EdgeInsets.only(bottom: 48),
              //   )
              ? ShapeAvatar(child: Icon(Icons.account_circle_rounded, size: MediaQuery.of(context).size.width))
              : SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: kIsWeb
                      ? Image.network(image.value!.path)
                      : cropp.value != null
                          ? Image.file(File(cropp.value!.path), fit: BoxFit.cover)
                          : Image.file(File(image.value!.path), errorBuilder: (context, error, stackTrace) => const Center(child: Text("image not supported"))),
                )
        },
      )),
      bottomNavigationBar: Container(
          // color: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // dummy button
              Flexible(
                flex: 2,
                child: Opacity(opacity: 0, child: TextButton(child: const Text("done"), onPressed: () => {})),
              ),
              // camera & gallery buttons
              Flexible(
                flex: 3,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  Flexible(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black, padding: const EdgeInsets.all(24), shape: const CircleBorder()),
                      child: const Icon(Icons.photo_camera_outlined),
                      onPressed: () async => doPicker(image, cropp, ImageSource.camera),
                    ),
                  ),
                  Flexible(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black, padding: const EdgeInsets.all(24), shape: const CircleBorder()),
                      child: const Icon(Icons.photo_library_outlined),
                      onPressed: () async => doPicker(image, cropp, ImageSource.gallery),
                    ),
                  ),
                ]),
              ),
              // done button
              Flexible(
                flex: 2,
                child: Opacity(
                    opacity: cropp.value == null ? 0 : 1,
                    child: TextButton(
                        child: const Text("done"),
                        onPressed: () async {
                          if (cropp.value == null) return;
                          final path = kIsWeb ? image.value!.path : (await getApplicationDocumentsDirectory()).path;
                          final name = image.value!.name;
                          final full = "$path/$name";
                          // cache image locally
                          //await image.value!.saveTo(full);
                          final data = await cropp.value!.readAsBytes();
                          final file = File(full);
                          await file.writeAsBytes(data);

                          // ref image to server
                          final ref = FirebaseStorage.instance.ref().child('images').child('user-id').child(name);
                          final meta = SettableMetadata(contentType: 'image/jpeg', customMetadata: {'path': full});

                          // upload
                          final snap = (await ref.putFile(file, meta));

                          print('SigningScreen::PicturePage ${snap.toString()}');

                          onDone!();
                        })),
              ),
            ],
          )),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key, this.onDone});

  final VoidCallback? onDone;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        ElevatedButton(onPressed: onDone, child: const Text("let's go")),
        Expanded(
          child: AsyncList(
            shrinkWrap: true,
            future: FirebaseStorage.instance.ref().child('images').child('user-id').listAllReferences(),
            itemBuilder: (context, index, item) => AsyncBuilder(
              future: item!.getDownloadURL(),
              builder: (context, url) => Container(color: Colors.purple, child: CachedNetworkImage(imageUrl: url, fit: BoxFit.cover)),
            ),
          ),
        ),
      ],
    ));
  }
}

// TOOD: (view) auth -> service (google|apple|fb|email) signin -> find or make (empty) user -> (view) form -> save user -> done (goto home)
