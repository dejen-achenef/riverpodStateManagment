import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final counterProvider = StateProvider((Ref ref) {
  return 0;
});

class stateProvider extends ConsumerWidget {
  const stateProvider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('widget rebuild');
    return Container(
      child: Column(children: [
        Consumer(
          builder: (context, ref, _) {
            final statepro = ref.watch(counterProvider);
            print('text rebuild');

            return Text(statepro.toString());
          },
        ),
        SizedBox(
          height: 30,
        ),
        ElevatedButton(
            onPressed: () {
              ref.read(counterProvider.notifier).state++;
            },
            child: Text("increment"))
      ]),
    );
  }
}
