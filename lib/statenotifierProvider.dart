import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

class Todo {
  final String title;
  final int id;
  final bool completed;

  Todo({required this.title, required this.id, required this.completed});

  Todo copyWith({String? title, int? id, bool? completed}) {
    return Todo(
        title: title ?? this.title,
        id: id ?? this.id,
        completed: completed ?? this.completed);
  }
}

class TodonotifierProvider extends StateNotifier<List<Todo>> {
  TodonotifierProvider(super.state);

  // void increment() => state++;
  // void reset() => state = 0;
  // void decrement() => state--;

  void TaskAdder(String? title) {
    final newlist = Todo(
        title: title!,
        id: state.isEmpty ? 0 : state.last.id + 1,
        completed: false);

    state = [...state, newlist];
  }

  void remove(int id) {
    state = state.where((t) => t.id != id).toList();
  }

  void toggle(int id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(completed: !todo.completed);
      }
      return todo;
    }).toList();
  }
}

final todoProvider =
    StateNotifierProvider<TodonotifierProvider, List<Todo>>((ref) {
  return TodonotifierProvider([]);
});

class StateNotifierPro extends ConsumerStatefulWidget {
  const StateNotifierPro({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StateNotifierProState();
}

class _StateNotifierProState extends ConsumerState<StateNotifierPro> {
  @override
  final textController = TextEditingController();
  Widget build(BuildContext context) {
    final list = ref.watch(todoProvider);
    final listAdder = ref.read(todoProvider.notifier);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 200, top: 500),
        child: Column(
          children: [
            TextFormField(
              controller: textController,
              decoration: InputDecoration(labelText: 'type task title'),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  final text = textController.text;
                  listAdder.TaskAdder(text);
                },
                child: Text('Add Todo')),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, i) {
                    return ListTile(
                      title: Text(
                        list[i].title,
                        style: TextStyle(
                            decoration: list[i].completed
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      leading: Checkbox(
                          value: list[i].completed,
                          onChanged: (_) {
                            listAdder.toggle(i);
                          }),
                      trailing: IconButton(
                          onPressed: () {
                            listAdder.remove(i);
                          },
                          icon: Icon(Icons.delete)),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
