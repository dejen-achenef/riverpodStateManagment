import 'package:flutterstate/hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class myapp extends StatelessWidget {
  myapp({super.key});

  @override
  final formkey = GlobalKey<FormState>();
  final imageController = new TextEditingController();
  final nameController = new TextEditingController();
  final ageController = new TextEditingController();
  final hivebox = Hive.box<UserModel>('users');
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(50),
              child: Form(
                  key: formkey,
                  child: Container(
                    width: double.infinity / 8,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'image url',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'bullshit put the fields first';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'image url',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          controller: imageController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'bullshit put the fields first';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'image url',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          controller: ageController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'bullshit put the fields first';
                            }
                            return null;
                          },
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                final newuser = UserModel(
                                    name: nameController.text,
                                    image: imageController.text,
                                    age: int.tryParse(ageController.text) ?? 0);

                                hivebox.add(newuser);
                              }
                            },
                            child: Text('save'))
                      ],
                    ),
                  )),
            ),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: Hive.box<UserModel>('users').listenable(),
                  builder: (context, Box<UserModel> box, _) {
                    if (box.isEmpty) return Text('no user found');
                    return ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          final user = box.getAt(index);
                          return ListTile(
                            title: Text(user!.name),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(user.age.toString()),
                                SizedBox(
                                  width: 50,
                                ),
                                IconButton(
                                    onPressed: () {
                                      user.delete();
                                    },
                                    icon: Icon(Icons.delete))
                              ],
                            ),
                            subtitle: Text(user.image),
                          );
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
