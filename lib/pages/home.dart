import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  String textOnField = '';

  final _buttonsStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xff00d7f3),
    padding: const EdgeInsets.all(17),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
  );

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
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Lista de tarefas',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: changed,
                      decoration: InputDecoration(
                        labelText: 'Adicione uma tarefa',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: pressButton,
                    child: Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.white,
                    ),
                    style: _buttonsStyle,
                  ),
                ],
              ),
              SizedBox(height: 16),
              ListView(
                children: [

                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Você possuí x tarefas pendentes',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Limpar tudo',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: _buttonsStyle,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  changed(String text) {
    textOnField = text;
  }

  pressButton() {
    print(textOnField);
  }
}
