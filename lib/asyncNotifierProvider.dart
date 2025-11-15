import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutterstate/futurepro.dart';

final someProvider = Provider((_) => apiService());
final asyncProvider = AsyncNotifierProvider<AsyncProviderotifier, String>(
    () => AsyncProviderotifier());

class AsyncProviderotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final somp = ref.read(someProvider);
    return await somp.fetchData();
  }

  Future<void> refreshing() async {
    final somp = await ref.read(someProvider).fetchData();

    try {
      state = AsyncValue.loading();
      state = AsyncValue.data(somp);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

class AsyncPro extends ConsumerStatefulWidget {
  const AsyncPro({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AsyncProState();
}

class _AsyncProState extends ConsumerState<AsyncPro> {
  @override
  Widget build(BuildContext context) {
    final value = ref.watch(asyncProvider);
    final valuegetter = ref.read(asyncProvider.notifier);
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: value.when(
                data: (tt) {
                  Text(tt);
                },
                error: (e, StackTrace) {
                  Text(e.toString());
                },
                loading: () => CircularProgressIndicator()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.refresh,
          size: 35,
        ),
        onPressed: valuegetter.refreshing,
      ),
    );
  }
}
