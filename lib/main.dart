import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'components/chart.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '/models/transaction.dart';
import '/components/transaction_form.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
 
  final ThemeData theme = ThemeData();

  @override
  
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: MyHomePage(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.green,
          secondary: Colors.lime,
          tertiary: Colors.orange,
        ),
        textTheme: theme.textTheme.copyWith(
          headline6: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        headline5:const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ), ),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )),
        /* primaryswatch recebe um conjunto de cores, primary apenas uma cor */
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = []; /* lista de transacoes */

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7), /* numero magico, cuidado */
      )); /* se data for depois de uma data subtraida 7 dias então é verdade(entrara na lista), se não, não é dos ultimos 7 dias */
    }).toList(); /* metodo parecido com filter, onde estamos filtrando apenas as transaçoes dos ultimos 7 dias */
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) =>
        tr.id == id); /* se o id da TR for igual o id passado como parametro, remove esse id */
      
    });
  }

  _addTransaction(String title, double value, DateTime date) {
    /* adicionando uma transacao, necessita do titulo e valor fornecidos pelo user */
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      /* gerar id randomicamente */
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context)
        .pop(); /*widget herdado apos adicionar uma nova transacao, fecha a primeira tela, de uma pilha de telas, ou seja, nesse caso fecha o modal */
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
            IconButton(
                onPressed: () => _opentransactionFormModal(context),
                icon: const Icon(Icons.add))
          ]),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
            /* para esticar os filhos da coluna(tipo full width) */
            children: [
              Chart(_recentTransactions),
              TransactionList(_transactions, _removeTransaction),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
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