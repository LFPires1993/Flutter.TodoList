import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _todoController = TextEditingController();

  String textOnField = '';

  final List<String> _todos = [];

  final _buttonsStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xff00d7f3),
    padding: const EdgeInsets.all(17),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Lista de tarefas',
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _todoController,
                        // onChanged: changed,
                        decoration: const InputDecoration(
                          labelText: 'Adicione uma tarefa',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: addTask,
                      style: _buttonsStyle,
                      child: const Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for(String todo in _todos)
                        TodoListItem(title: todo)
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Você possuí ${_todos.length} tarefas pendentes',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: clearList,
                      style: _buttonsStyle,
                      child: const Text(
                        'Limpar tudo',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  addTask() {
    setState(() {
      _todos.add(_todoController.text);
      _todoController.clear();
    });
  }

  clearList() {
    setState(() {
      _todos.clear();
    });
  }
}
