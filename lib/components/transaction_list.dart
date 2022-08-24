import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transactions);

  final List<Transaction> transactions;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              /* se a lista esta vazia, mostra coluna, se não, mostra listview */
              children: [
                Text(
                  'Nenhuma Transacão Cadastrada!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 250,
                  child: Image.asset(
                    'assets/images/sleeping_cat.png',
                    fit: BoxFit.cover, /*  */
                  ),
                ),
              ],
            )
          : ListView.builder(
              /* uma lista que permite scrolling, builder faz com que economize memoria nao renderizando componentes que nao estao visiveis */
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    /* permite personalização maior em cada componente da lista */
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          /* para o texto se encaixar */
                          child: Text(
                            'R\$${tr.value}',
                          style: Theme.of(context).textTheme.headline5,),
                        ),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(tr.date),
                    ),
                  ),
                );
              },
              /* aqui, pegando os titulos das transações os colocando na coluna */
            ),
    );
  }
}
