import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:project_social/framework/hooks.dart';

typedef HobbyItem = String;
typedef HobbyList = List<HobbyItem>;

Future<HobbyList?> showInterestsPicker({required BuildContext context, String? title, HobbyList? inital}) async {
  try {
    final future = Future.delayed(const Duration(milliseconds: 250), () async {
      final List<HobbyItem> hobbies = [];
      {
        final response = await rootBundle.loadString("asset/data/hobbies.json", cache: false);
        final List<dynamic> decoded = await json.decode(response);
        for (int i = 0, l = decoded.length; i < l; i++) {
          // categories.add(HobbyCategory.fromJson(decoded[i]));
          hobbies.addAll(List<HobbyItem>.from(decoded[i]["hobbies"]));
          // count += categories[i].hobbies.length;
        }
      }
      return hobbies;
    });

    return showDialog<HobbyList?>(
        // ignore: use_build_context_synchronously
        barrierColor: Colors.black.withOpacity(0.9),
        context: context,
        builder: (context) => HookBuilder(builder: (context) {
              print("HookBuilder");
              final hobbies = useSet<HobbyItem>({...inital ?? []});
              return Dialog(
                  backgroundColor: Theme.of(context).dialogBackgroundColor,
                  insetPadding: const EdgeInsets.symmetric(vertical: 64, horizontal: 64),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: FutureBuilder(
                      future: future,
                      builder: (context, snapshot) => (!snapshot.hasData)
                          ? const Center(child: CircularProgressIndicator())
                          : Column(children: [
                              Container(
                                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    const Spacer(),
                                    Flexible(flex: 4, child: Text(title ?? "Select interests", textAlign: TextAlign.center)),
                                    Flexible(
                                        flex: 1,
                                        child: TextButton(
                                          onPressed: () => Navigator.of(context).pop(hobbies.toList()),
                                          child: const Text("done"),
                                        )),
                                  ])),
                              Expanded(
                                  child: Container(
                                padding: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
                                child: SingleChildScrollView(
                                    child: Wrap(
                                  alignment: WrapAlignment.spaceAround,
                                  runAlignment: WrapAlignment.center,
                                  spacing: 10,
                                  runSpacing: 5,
                                  children: snapshot.data!
                                      .map((hobby) => ChoiceChip(
                                            label: Text(hobby),
                                            showCheckmark: false,
                                            selected: hobbies.contains(hobby),
                                            backgroundColor: const Color(0xFF2B2930),
                                            side: const BorderSide(color: Color(0xFF797389)),
                                            onSelected: (value) => hobbies.toggle(hobby),
                                          ))
                                      .toList(),
                                )),
                              )),
                            ])));
            }));
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
