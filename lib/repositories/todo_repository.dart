import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo.dart';

const String _todoListKey = 'todoList';

class TodoRepository {

  late SharedPreferences _sharedPreferences;

  Future saveTodos(List<Todo> todos) async {
    final finalJson = json.encode(todos);
    await _sharedPreferences.setString(_todoListKey, finalJson);
  }

  Future<List<Todo>> getTodos() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final String todosJson = _sharedPreferences.getString(_todoListKey) ?? '[]';
    final List jsonList = json.decode(todosJson) as List;
    return jsonList.map((e) => Todo.fromJson(e)).toList();
  }
}