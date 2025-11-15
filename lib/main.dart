import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterstate/asyncNotifierProvider.dart';
import 'package:flutterstate/futurepro.dart';
import 'package:flutterstate/hive_model.dart';
import 'package:flutterstate/myhiveAPP.dart';
import 'package:flutterstate/statefulconsumer.dart';
import 'package:flutterstate/statenotifierProvider.dart';
import 'package:flutterstate/stateprovider.dart';
import 'package:flutterstate/streamProvider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('users');
  runApp(ProviderScope(child: MaterialApp(home: AsyncPro())));
}
