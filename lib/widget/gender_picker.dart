import 'package:flutter/material.dart';

final genders = ['female', 'male', 'transgender', 'other'];

enum Gender { female, male, transgender, other }

extension GenderExtension on Gender {
  String get name => switch (this) {
        Gender.female => 'female',
        Gender.male => 'male',
        Gender.transgender => 'transgender',
        Gender.other => 'other',
      };
  int get index => switch (this) {
        Gender.female => 0,
        Gender.male => 1,
        Gender.transgender => 2,
        Gender.other => 3,
      };
}

extension GenderExtensionNull on Gender? {
  String get name {
    if (this == null) return Gender.female.name;
    return this!.name;
  }
}

Future<Gender?> showGenderPicker({required BuildContext context, String? title}) async {
  try {
    return showDialog<Gender?>(
        barrierColor: Colors.black.withOpacity(0.9),
        context: context,
        builder: (context) => Dialog(
            insetPadding: const EdgeInsets.symmetric(vertical: 200, horizontal: 80),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(children: [
              Container(padding: const EdgeInsets.symmetric(vertical: 20), child: Text(title ?? "Select gender")),
              ListView.builder(
                shrinkWrap: true,
                itemCount: Gender.values.length,
                itemBuilder: (context, i) => ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 32),
                  titleAlignment: ListTileTitleAlignment.center,
                  //leading: Text(Gender.values[i].name),
                  title: Text(Gender.values[i].name),
                  onTap: () {
                    Navigator.of(context).pop(Gender.values[i]);
                  },
                ),
              ),
            ])));
  } catch (e) {
    return showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Error!"),
              icon: const Icon(Icons.error_outlined, color: Colors.red),
              content: Text(e.toString()),
              actions: [TextButton(onPressed: () => Navigator.of(context).pop(null), child: const Text("Ok"))],
            ));
  }
}
