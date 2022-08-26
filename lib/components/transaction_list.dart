import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transactions, this.onRemove);

  final List<Transaction> transactions;
  final Function(String) onRemove;

  @override
  Widget build(BuildContext context) {
    /* contexto diz exatamente qual componente esta sendo renderizado, o contexto do filho consegue acessar o contexto pai */

    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                /* se a lista esta vazia, mostra coluna, se não, mostra listview */
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Nenhuma Transacão Cadastrada!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/sleeping_cat.png',
                      fit: BoxFit.cover, /*  */
                    ),
                  ),
                ],
              );
            },
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
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat('d MMM y', 'pt_BR').format(tr.date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? TextButton.icon(
                          onPressed: () => onRemove(tr.id),
                          icon: Icon(Icons.delete,
                          color: Theme.of(context).errorColor),
                          label: Text('Excluir',
                          style: TextStyle(color: Theme.of(context).errorColor),),
                           
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => onRemove(tr.id),
                        ),
                ),
              );
            },
            /* aqui, pegando os titulos das transações os colocando na coluna */
          );
  }
}
