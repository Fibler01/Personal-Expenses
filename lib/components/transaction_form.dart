import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget { /* precisa ser stateful p texteditingcontroller funcionar corretamente */
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}
  class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now(); 

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0; /* caso ele nao consiga transformar texto em double, retorna 0,0 */

    if(title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate as DateTime);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019), /* usuario consegue selecionar a partir de 2019 */
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate; /* sempre é necessario colocar setstate ao alterar um dado e vc quiser mostrar essa alteração na tela */
      });
      
    });
    print('Executado!!!');
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  right: 10,
                  left: 10,
                  bottom: 10 + MediaQuery.of(context).viewInsets.bottom, /* MediaQuery p descobrir tamanho do teclado */
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController, /* fazendo titulo receber o titulo (que o usuario escreveu) */
                      onSubmitted: (_) => _submitForm(), /* nesse caso, ele ira tentar submeter, mas como faltara valores, nao submetera e apenas fechara o teclado */
                      decoration: InputDecoration(
                        labelText: 'Título',
                      ),
                    ),
                    TextField(
                      controller: _valueController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true), /* p forçar que tenha os '.' e ',' fazendo com que abra apenas teclado numerico */
                      onSubmitted: (_) => _submitForm(),  /* submitando form apos submitar o ultimo campo(valor) */
                      decoration: InputDecoration(
                        labelText: 'Valor (R\$)',
                      ),
                    ),
                    Container(
                      height:70,
                      child: Row(
                      children: [
                        Expanded(child: Text(_selectedDate == null ? 'Nenhuma data selecionada!' /* se nao tiver data selecionada, se não, mostrar selected date */
                         : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate as DateTime)}',),),
                        
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Theme.of(context).colorScheme.primary,
                            
                          ),
                          child: Text('Selecionar Data',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          ), 
                          onPressed:  _showDatePicker,
                        )
                      ]
                    ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: _submitForm,
                          child: Text(
                            'Nova Transação',
                            style: TextStyle(/* color: Colors.white */),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}