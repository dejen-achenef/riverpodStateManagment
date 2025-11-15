import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutterstate/futurepro.dart';

final someProvider = Provider((_) => apiService());

class AsyncProviderNotifier extends AsyncNotifier<String> {
  Future<String> build() async {
    final somp = ref.read(someProvider);
    return await somp.fetchData();
  }
}
