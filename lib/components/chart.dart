import 'package:expenses/components/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  const Chart(this.recentTransaction, {Key? key})
      : super(key: key); /* recebe as transaçoes recentes */

  final List<Transaction> recentTransaction;

  

  List<Map<String, dynamic>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(
            days:
                index), /* subtrai do dia de hoje os valores p gerar o grafico */
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum +=
              recentTransaction[i].value; /* somando as transaçoes do dia */
        }
      }

      return {
        'day': DateFormat.E('pt_BR').format(weekDay), /* transformando dia em data do br */
        'value': totalSum,
      }; /* pegando a primeira letra do dia */
    })
        .reversed
        .toList(); /* gerando lista de 7 elementos, reversed p ir da direita p esquerda(dia atual a direita, anteriores a esquerda
    ) (pcausa dos dias na semana) */
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + tr['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      /* margem dos componentes do card */
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                tr['day'] as String,
                /* label, dia da semana */
                tr['value'] as double,
                /* value */
                _weekTotalValue == 0 ? 0 :(tr['value'] as double) /  /* garantindo que não sera dividido por 0, se ele for 0 não retorna nada */
                    _weekTotalValue, /* percentage, pegando o valor e dividindo pelo valor total da semana p gerar a porcentagem */
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
