import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:project_social/utilities/hooks.dart';

class Message {
  Message({required this.id, required this.body, required this.from, required this.seen});
  String id;
  late String body;
  late String from;
  late bool seen;
}

class ChatterScreen extends HookWidget {
  const ChatterScreen({super.key, required this.other});

  final String other;

  Stream<List<Message>> getMessages() async* {
    print('ChatterScreen::getMessages()');
    for (int i = 0; i < 6; i++) {
      yield await Future.delayed(const Duration(seconds: 1), () {
        print('ChatterScreen::getMessages() delayed $i');
        return [
          Message(id: "${i.toString()}_01", body: "stream.stream.stream", from: "0002", seen: false),
          Message(id: "${i.toString()}_02", body: "stream", from: "0001", seen: true),
          Message(id: "${i.toString()}_03", body: "stream", from: "0002", seen: false),
        ];
      });
    }
  }

  final u1st = '0001';
  final u2nd = '0002';

  @override
  Widget build(BuildContext context) {
    print('ChatterScreen::build()');

    final items = useRef<List<Message>>([]);
    final controller = useRef<StreamController<List<Message>>>(StreamController());
    useMount(() async {
      await controller.value.addStream(getMessages());
    });
    final number = useState(0);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('chatter'),
        centerTitle: true,
        leading: InkWell(
          onTap: () => GoRouter.of(context).go('/connect'),
          child: const Icon(Icons.arrow_back_outlined),
        ),
        actions: [ElevatedButton(onPressed: () => number.value++, child: Text('${number.value}'))],
      ),
      extendBodyBehindAppBar: false,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.background,
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
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 4, right: 4),
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        itemCount: items.value.length,
                        itemBuilder: (context, index) {
                          final item = items.value[index];
                          final from = item.from != u1st;
                          final same = index < items.value.length - 1 && item.from == items.value[index + 1].from;
                          final head = (index == items.value.length - 1) || (items.value[index + 1].from != item.from);
                          final tail = (index == 0) || (items.value[index - 1].from != item.from);
                          return Row(
                            children: [
                              Flexible(
                                flex: from ? 0 : 1,
                                child: Container(),
                              ),
                              Flexible(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: item.from == u1st ? Colors.blueAccent : Colors.redAccent,
                                    borderRadius: BorderRadius.only(
                                      topLeft: head ? const Radius.circular(16) : const Radius.circular(4),
                                      topRight: head ? const Radius.circular(16) : const Radius.circular(4),
                                      bottomRight: tail ? const Radius.circular(16) : const Radius.circular(4),
                                      bottomLeft: tail ? const Radius.circular(16) : const Radius.circular(4),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(left: from ? 12 : 8, right: !from ? 12 : 8, top: 8, bottom: 8),
                                  margin: EdgeInsets.only(top: same ? 2 : 8),
                                  child: Align(
                                    alignment: from ? Alignment.centerLeft : Alignment.centerRight,
                                    child: Text("$index: id=${items.value[index].id} body=${items.value[index].body} from=${items.value[index].from} seen=${items.value[index].seen} "),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: from ? 1 : 0,
                                child: Container(),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
