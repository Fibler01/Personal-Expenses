import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/components/transaction_user.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          /* para esticar os filhos da coluna(tipo full width) */
          children: [
            Container(
              child: const Card(
                color: Colors.blue,
                elevation: 5,
                child: Text(
                    'Gráfico'), /* para parecer que o elemento está mais a frente na tela */
              ),
            ),
            TransactionUser(),
          ]),
    );
  }
}
