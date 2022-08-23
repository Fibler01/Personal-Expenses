
import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: titleController, /* fazendo titulo receber o titulo (que o usuario escreveu) */
                      decoration: InputDecoration(
                        labelText: 'Título',
                      ),
                    ),
                    TextField(
                      controller: valueController,
                      decoration: InputDecoration(
                        labelText: 'Valor (R\$)',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {print(titleController.text); print(valueController.text);},
                          child: Text(
                            'Nova Transação',
                            style: TextStyle(color: Colors.green.shade700),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
  }
}