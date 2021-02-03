import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './adaptative_flat_button.dart';

class TransactionForm extends StatefulWidget {
  final Function submitHandler;
  
  TransactionForm(this.submitHandler) {
    print('Construction TransactionForm');

  }

  @override
  _TransactionFormState createState(){
    print('createState TransactionForm');
    return _TransactionFormState();
  }
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _TransactionFormState() {
    print('_TransactionFormState constructor');
  }

  @override
  void initState() {
    print('initState() TransactionFormState');
    super.initState();
  }

  @override
  void didUpdateWidget(TransactionForm oldWidget) {
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose()');
    super.dispose();
  }

  void _submitData() {
    final title = _titleController.text.trim();
    final amount = double.parse(_amountController.text);

    if (title.isEmpty || title == '' || amount <= 0 || _selectedDate == null) {
      return;
    }

    widget.submitHandler(
      title,
      amount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                          ? 'No date selected!'
                          : 'Selected date: ${DateFormat.yMd().format(_selectedDate)}'
                      ),
                    ),
                    AdaptiveFlatButton(text: 'Chose a date', handler: _showDatePicker)
                  ],
                ),
              ),
              ElevatedButton(
                child: const Text('Add transaction'),
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}