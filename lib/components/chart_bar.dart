import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String? label;
  final double? value;
  final double? percentage;

  const ChartBar(this.label, this.value, this.percentage, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        /* pega as restriçoes do contexto de onde o componente esta sendo criado, no caso a coluna */
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.15,
              /* para arrumar desalinhamento causado ao colocar valor muito grande */
              child: FittedBox(
                /* para conseguir encaixar o valor, diminuindo a fonte se o valor for mto grande */
                child: Text('${value?.toStringAsFixed(2)}'),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.6,
              /* usando 80% do tamanho do card p o grafico */
              width: 10,
              child: Stack(
                alignment: Alignment.bottomCenter,
                /* para deixar a barra funcionando debaixo para cima */
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius:
                          BorderRadius.circular(5), /* deixando barra redonda */
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                ],
              ), /* stack permite colocar um componente em cima do outro, um componente sera o formato da barra, o outro como preenchimento */
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(label!)), /* texto dos dias da semana */
            ),
          ],
        );
      },
    );
  }
}
