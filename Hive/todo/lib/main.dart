import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/todo.dart';

import 'new_todo_dialog.dart';
import 'todo_list.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive To-Do App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: FutureBuilder(
            future: Future.wait([
              Hive.openBox('settings'),
              Hive.openBox<Todo>('todos'),
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.error != null) {
                  if (kDebugMode) {
                    print(snapshot.error);
                  }
                  return const Scaffold(
                    body: Center(
                      child: Text('Something went wrong :/'),
                    ),
                  );
                } else {
                  return const TodoMainScreen();
                }
              } else {
                /*return const Scaffold(
                  body: Center(
                    child: Text('Opening Hive...'),
                  ),
                );*/
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}

class TodoMainScreen extends StatelessWidget {
  const TodoMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ValueListenableBuilder(
            valueListenable: Hive.box('settings').listenable(),
            builder: _buildWithBox,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const NewTodoDialog();
            },
          );
        },
      ),
    );
  }

  Widget _buildWithBox(
      BuildContext context, Box<dynamic> settings, Widget? child) {
    var reversed = settings.get('reversed', defaultValue: true) as bool;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Hive To-Do',
              style: TextStyle(fontSize: 40),
            ),
            const SizedBox(width: 20),
            IconButton(
              icon: Icon(
                reversed ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 32,
              ),
              onPressed: () {
                settings.put('reversed', !reversed);
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          kIsWeb
              ? 'Refresh this tab to test persistence.'
              : 'Restart the app to test persistence.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Expanded(
          child: ValueListenableBuilder<Box<Todo>>(
            valueListenable: Hive.box<Todo>('todos').listenable(),
            builder: (context, box, _) {
              var todos = box.values.toList().cast<Todo>();
              if (reversed) {
                todos = todos.reversed.toList();
              }
              return TodoList(todos);
            },
          ),
        ),
      ],
    );
  }
}
