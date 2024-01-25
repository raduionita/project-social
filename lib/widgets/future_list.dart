import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:project_social/utilities/hooks.dart';

class FutureList<T> extends HookWidget {
  const FutureList({super.key, required this.futureCaller, this.initialData, required this.itemBuilder, this.waitingBuilder, this.errorBuilder});

  final Future<List<T>> Function() futureCaller;
  final List<T>? initialData;
  final Widget Function(BuildContext context, int index, T? item) itemBuilder;
  final Widget Function(BuildContext context)? waitingBuilder;
  final Widget Function(BuildContext context)? errorBuilder;

  @override
  Widget build(BuildContext context) {
    print('FutureList::build()');
    final memorized = useMemorizedFuture(this.futureCaller);
    return FutureBuilder<List<T>>(
      key: key,
      initialData: this.initialData,
      future: memorized,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return this.waitingBuilder != null ? this.waitingBuilder!(context) : const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return this.errorBuilder != null ? this.errorBuilder!(context) : Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            // final list = snapshot.data?.toList();
            return ListView.builder(
              shrinkWrap: true,
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
