import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:project_social/utilities/hooks.dart';

class Message {
  Message({required this.id, required this.body, required this.from, required this.seen});
  String id;
  late String body;
  late String from;
  late bool seen;
}

class ChatterScreen extends HookWidget {
  const ChatterScreen({super.key});

  Stream<List<Message>> getMessages() async* {
    print('getMessages()');
    for (int i = 0; i < 3; i++) {
      yield await Future.delayed(const Duration(seconds: 1), () {
        print('getMessages() delayed $i');
        return [
          Message(id: "${i.toString()}_01", body: "stream", from: "0001", seen: false),
          Message(id: "${i.toString()}_02", body: "stream", from: "0002", seen: true),
          Message(id: "${i.toString()}_03", body: "stream", from: "0003", seen: false),
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('ChatterScreen::build()');
    final items = useRef<List<Message>>([]);
    final controller = useRef<StreamController<List<Message>>>(StreamController());
    useMount(() async {
      await controller.value.addStream(getMessages());
    });

    return SafeArea(
      child: Container(
        color: Colors.grey,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: controller.value.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print('ChatterScreen::StreamBuilder error');
                    return Text(snapshot.error.toString());
                  } else if (snapshot.connectionState == ConnectionState.waiting) {
                    print('ChatterScreen::StreamBuilder waiting');
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    print('ChatterScreen::StreamBuilder done ${items.value.length}');
                    //return empty;
                  } else /* == ConnectionState.active */ {
                    items.value.insertAll(0, snapshot.data!);
                    print('ChatterScreen::StreamBuilder ${snapshot.connectionState.name}');
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: items.value.length,
                    itemBuilder: (context, index) {
                      return Text("$index: id=${items.value[index].id} body=${items.value[index].body} from=${items.value[index].from} seen=${items.value[index].seen} ");
                    },
                  );
                },
              ),
              ElevatedButton(
                child: const Text('add'),
                onPressed: () {
                  controller.value.sink.add([
                    Message(id: 'id', body: 'body', from: 'from', seen: true),
                  ]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
