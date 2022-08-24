
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget { /* precisa ser stateful p texteditingcontroller funcionar corretamente */
  final void Function(String, double) onSubmit;

  const TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}
  class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();
  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0; /* caso ele nao consiga transformar texto em double, retorna 0,0 */

    if(title.isEmpty || value <= 0 ) {
      return;
    }
    widget.onSubmit(title, value);
  }

  
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
                      onSubmitted: (_) => _submitForm(), /* nesse caso, ele ira tentar submeter, mas como faltara valores, nao submetera e apenas fechara o teclado */
                      decoration: InputDecoration(
                        labelText: 'Título',
                      ),
                    ),
                    TextField(
                      controller: valueController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true), /* p forçar que tenha os '.' e ',' fazendo com que abra apenas teclado numerico */
                      onSubmitted: (_) => _submitForm(),  /* submitando form apos submitar o ultimo campo(valor) */
                      decoration: InputDecoration(
                        labelText: 'Valor (R\$)',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: _submitForm,
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