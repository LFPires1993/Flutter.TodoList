import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/repositories/todo_repository.dart';
import 'package:todo_list/widgets/todo_list_item.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TodoRepository _todoRepository = TodoRepository();

  final Color _primaryColor = const Color(0xff00d7f3);
  final TextEditingController _todoController = TextEditingController();
  final List<Todo> _todos = [];
  final RoundedRectangleBorder _defaultShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5));

  _buttonsStyle({Color? backgroundColor}) => ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? _primaryColor,
        padding: const EdgeInsets.all(17),
        shape: _defaultShape,
      );

  @override
  void initState() {
    super.initState();
    _todoRepository.getTodos().then((value) => setState(() {
      _todos.addAll(value);
    }));
  }

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
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
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
                      style: _buttonsStyle(),
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
                      for (Todo todo in _todos.reversed)
                        TodoListItem(todo: todo, onDelete: onDelete),
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
                      onPressed: showDeleteModal,
                      style: _buttonsStyle(),
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

  onDelete(Todo todo) {
    int deletedTodoIndex = _todos.indexOf(todo);

    setState(() {
      _todos.remove(todo);
      _todoRepository.saveTodos(_todos);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      elevation: 0,
      action: SnackBarAction(
        label: 'Desfazer',
        textColor: Colors.blue[800],
        onPressed: () {
          setState(() {
            _todos.insert(deletedTodoIndex, todo);
            _todoRepository.saveTodos(_todos);
          });
        },
      ),
      content: Text(
        'Tarefa ${todo.title} removida com sucesso!',
        style: TextStyle(
          color: Colors.blue[900],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ));
  }

  addTask() {
    setState(() {
      _todos.add(Todo(title: _todoController.text, dateTime: DateTime.now()));
      _todoController.clear();
      _todoRepository.saveTodos(_todos);
    });
  }

  showDeleteModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: _defaultShape,
        title: const Text('Limpar lista!'),
        content: const Text(
          'Você tem certeza que deseja apagar todas as tarefas?',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              clearList();
              Navigator.of(context).pop();
            },
            child: const Text(
              'Deletar',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancelar',
              style: TextStyle(
                color: _primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  clearList() {
    setState(() {
      _todos.clear();
      _todoRepository.saveTodos(_todos);
    });
  }
}
