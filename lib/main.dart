import 'package:drift/drift.dart' as d;
import 'package:drift_web/databse/tables.dart';
import 'package:flutter/material.dart';

MyDatabase? database;

void main() {
  database = MyDatabase();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Drift (Moor)"),
        ),
        body: FutureBuilder<List<Todo>>(
          future: database?.getTodos(),
          builder: (context, s) {
            if (s.hasData) {
              if (s.data!.isNotEmpty) {
                List<Todo>? data = s.data;

                return Center(
                  child: Column(
                    children: data!.map((e) => Text(e.title!)).toList(),
                  ),
                );
              } else {
                return const Center(
                  child: Text("empty"),
                );
              }
            }
            return Container();
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Text("save"),
          onPressed: () {
            database!.saveTodo(
              TodosCompanion(
                title: d.Value("value " + DateTime.now().toString()),
              ),
            );
            setState(() {});
          },
        ),
      ),
    );
  }
}
