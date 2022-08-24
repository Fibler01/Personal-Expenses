import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '/models/transaction.dart';
import '/components/transaction_form.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Tenis',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta',
      value: 211.30,
      date: DateTime.now(),
    ),
  ]; /* lista de transacoes */

  _addTransaction(String title, double value) {
    /* adicionando uma transacao, necessita do titulo e valor fornecidos pelo user */
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      /* gerar id randomicamente */
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  _opentransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Despesas Pessoais'),
          actions: <Widget>[
            IconButton(onPressed: () => _opentransactionFormModal(context), icon: Icon(Icons.add))
          ]),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
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
              TransactionList(_transactions),            
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _opentransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}



/* Column(
                children: [
                  TransactionForm(_addTransaction),
                  /* pedindo p transactionform passar o titulo e o valor, a partir da funcao onsubmit, p inseri-los na lista */
                  
                ],
              ) */