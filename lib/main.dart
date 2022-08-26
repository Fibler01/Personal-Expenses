import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';

import 'components/chart.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '/models/transaction.dart';
import '/components/transaction_form.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    /* SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp
    ]); /* exemplo de definição de orientação fixa */ */

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      /* adicionando localizaçÕes */

      supportedLocales: const [Locale('pt', 'BR')],
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
          headline5: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
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
  bool _showChart = false;

  late Locale _locale;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

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
          tr.id ==
          id); /* se o id da TR for igual o id passado como parametro, remove esse id */
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
    bool isLandscape = MediaQuery.of(context).orientation ==
        Orientation.landscape; /* orientação paisagem */

    final appBar = AppBar(
        centerTitle: true,
        title: const Text(
          'Despesas Pessoais',
        ),
        actions: <Widget>[
          if(isLandscape)
          IconButton(
              onPressed: () { setState(() {
                _showChart = !_showChart;
              });},
              
              icon: Icon(_showChart ? Icons.list : Icons.show_chart)),
          IconButton(
              onPressed: () => _opentransactionFormModal(context),
              icon: const Icon(Icons.add)),
          
        ]);

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    /* vendo altura disponivel inicial descontando o appbar e barra de navegacao !IMPORTANT*/
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
            /* para esticar os filhos da coluna(tipo full width) */
            children: [
              /* if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Exibir Gráfico'),
                    Switch(
                      /* botao on off */
                      value: _showChart,
                      onChanged: (value) {
                        setState(() {
                          _showChart = value;
                        });
                      },
                    ),
                  ],
                ), */
              if (_showChart ||
                  !isLandscape) /* se showchart for verdade, mostra o gráfico, se não, não mostra */
                Container(
                  child: Chart(_recentTransactions),
                  height: availableHeight * (isLandscape ? 0.6 : 0.30),
                ),
              if (!_showChart || !isLandscape)
                Container(
                  child: TransactionList(_transactions, _removeTransaction),
                  height: availableHeight * 0.70,
                ), /* pegando a altura disponivel, e pegando 60% dela */
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _opentransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}



/* Column(
                children: [
                  TransactionForm(_addTransaction),
                  /* pedindo p transactionform passar o titulo e o valor, a partir da funcao onsubmit, p inseri-los na lista */
                  
                ],
              ) */