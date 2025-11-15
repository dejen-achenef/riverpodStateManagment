import "package:hive_flutter/hive_flutter.dart";
import 'package:hive/hive.dart';
part 'hive_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String image;
  @HiveField(2)
  final int age;

  UserModel({required this.name, required this.image, required this.age});
}
