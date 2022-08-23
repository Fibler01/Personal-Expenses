import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transactions);

  final List<Transaction> transactions;
  @override
  Widget build(BuildContext context) {
    return Column(
      /* aqui, pegando os titulos das transações os colocando na coluna */
      children: transactions.map((tr) {
        return Card(
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  /* adicionando uma boxdecoration no container */
                  border: Border.all(
                    color: Colors.green.shade300,
                    width: 2,
                  ),
                ),
                padding: EdgeInsets.all(10),
                child: Text(
                  'R\$ ${tr.value.toStringAsFixed(2)}',
                  /* interpolando real com o valor, poderia ser feito também: 'R\$ ' + tr.value.toString() */
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green.shade700,
                  ),
                ), /* pegando valor da transação */
              ),
              Column(
                /*  mainAxisAlignment: MainAxisAlignment.center, fonte 16, peso bold, embaixo cinza */
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    DateFormat('d MMM y').format(tr.date),
                    /* tr.date.toString(), utilizando intl para formatar a data dia mes e ano*/
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
