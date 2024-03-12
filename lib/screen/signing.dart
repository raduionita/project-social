import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:project_social/framework/environment.dart';
import 'package:project_social/framework/extensions.dart';
import 'package:project_social/framework/session.dart';
import 'package:project_social/widget/country_picker.dart';
import 'package:project_social/widget/custom_logo.dart';
import 'package:project_social/widget/signin_button.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SigningScreen extends HookWidget {
  const SigningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('SigningScreen::build(${Provider.of<Environment>(context)})');

    final controller = usePageController(initialPage: 0, keepPage: true);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          SigningPage(onDone: () => controller.animateToPage(1, duration: const Duration(milliseconds: 250), curve: Curves.linear)),
          DetailsPage(onDone: () => controller.animateToPage(0, duration: const Duration(milliseconds: 250), curve: Curves.linear)),
        ],
      )),
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
                        icon: const Icon(Icons.login_outlined),
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
                        icon: const Icon(Icons.login_outlined),
                        label: const Text(" Sign-in with Apple"),
                        onPressed: () {
                          // done
                          onDone!();
                        },
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: SignInButton(
                        icon: const Icon(Icons.login_outlined),
                        label: const Text(" Sign-in with Facebook"),
                        onPressed: () {
                          // done
                          onDone!();
                        },
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: SignInButton(
                        icon: const Icon(Icons.phone_enabled_outlined),
                        label: const Text(" Sign-in with Phone"),
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
    final first = DateTime(1900);
    final last = DateTime(now.year - 18, now.month, now.day);

    final name = useTextEditingController();
    final birthDate = useTextEditingController();
    final country = useTextEditingController();
    final gender = useTextEditingController();

    return Column(
      children: [
        Form(
          key: formKey,
          child: Flex(
            direction: Axis.vertical,
            children: [
              SizedBox(
                  height: 80,
                  child: TextFormField(
                    controller: name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(hintText: "Enter your name"),
                    onSaved: (value) => name.text = value ?? "",
                    validator: (value) => value == null || value.isEmpty ? 'Name cannot be empty' : null,
                  )),
              const Divider(),
              TextFormField(
                controller: birthDate,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.none,
                decoration: const InputDecoration(hintText: "Enter your birth date"),
                onTap: () async => birthDate.text = (await showDatePicker(context: context, firstDate: first, lastDate: last, initialDatePickerMode: DatePickerMode.year)).toDate(),
                validator: (value) => value == null || value.isEmpty || value == '0000-00-00' ? 'Birth date cannot be empty' : null,
              ),
              const Divider(),
              Row(children: [
                Flexible(
                  child: TextFormField(
                    controller: country,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.none,
                    decoration: const InputDecoration(hintText: "Select your country"),
                    onTap: () async => country.text = (await showCountryPicker(context: context))!.name,
                    validator: (value) => value == null || value.isEmpty ? 'Country cannot be empty' : null,
                  ),
                ),
                const VerticalDivider(color: Colors.white),
                Flexible(
                    child: TextFormField(
                  onTap: () {},
                ))
              ]),
              const Divider(),
              Row(children: [
                DropdownMenu<String>(
                    controller: gender,
                    dropdownMenuEntries: const [
                      DropdownMenuEntry<String>(value: "female", label: "female"),
                      DropdownMenuEntry<String>(value: "male", label: "male"),
                      DropdownMenuEntry<String>(value: "transgender", label: "transgender"),
                      DropdownMenuEntry<String>(value: "other", label: "other"),
                    ],
                    onSelected: (value) => gender.text = value ?? "")
              ]),
              const Divider(),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                    }
                    inspect(formKey.currentState);
                  },
                  child: const Text("submit"))
            ],
          ),
        )
      ],
    );
  }
}

// TOOD: (view) auth -> service (google|apple|fb|email) signin -> find or make (empty) user -> (view) form -> save user -> done (goto home)
