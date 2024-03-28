import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AsyncList<T> extends HookWidget {
  const AsyncList({super.key, required this.future, this.initialData, required this.itemBuilder, this.waitingBuilder, this.errorBuilder, this.shrinkWrap = false});

  final Future<List<T>> future;
  final List<T>? initialData;
  final Widget Function(BuildContext context, int index, T? item) itemBuilder;
  final Widget Function(BuildContext context)? waitingBuilder;
  final Widget Function(BuildContext context)? errorBuilder;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    print('FutureList::build()');
    return FutureBuilder<List<T>>(
      key: key,
      initialData: this.initialData,
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return this.waitingBuilder != null ? this.waitingBuilder!(context) : const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return this.errorBuilder != null ? this.errorBuilder!(context) : Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            // final list = snapshot.data?.toList();
            return ListView.builder(
              shrinkWrap: shrinkWrap,
              //itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                if (index < snapshot.data!.length) {
                  return this.itemBuilder(context, index, snapshot.data![index]);
                }
                return null;
              },
            );
          }
        }
        return Container();
      },
    );
  }
}
