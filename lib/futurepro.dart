import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

class apiService {
  Future<String> fetchData() async {
    Future.delayed(Duration(seconds: 3));
    if (Random().nextDouble() <= 0.3) {
      throw Exception('faild to load data');
    }
    ;

    return 'hello from async';
  }
}

final greetingProvider = Provider((ref) => apiService());

final greatingService = FutureProvider((Ref ref) async {
  final service = await ref.read(greetingProvider);
  return service.fetchData();
});

class Futurepro extends ConsumerWidget {
  const Futurepro({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncservice = ref.watch(greatingService);
    return Scaffold(
        body: Center(
      child: asyncservice.when(
          data: (user) => Text(user),
          error: (error, StackTrace) => Text(error.toString()),
          loading: () => CircularProgressIndicator()),
    ));
  }
}
