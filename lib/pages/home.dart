import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Lista de tarefas'),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Digite sua tarefa',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => {},
                child: Icon(Icons.add),
              )
            ],
          ),
        ),
      ),
    );
  }
}
