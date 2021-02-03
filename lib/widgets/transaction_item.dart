import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransactionHandler,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransactionHandler;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$ ${transaction.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6
        ),
        subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
        trailing: MediaQuery.of(context).size.width > 460 
        ? TextButton.icon(
          icon: const Icon(Icons.delete),
          style: TextButton.styleFrom(
            primary: Theme.of(context).errorColor
          ),
          label: const Text('Delete'),
          onPressed: () => deleteTransactionHandler(transaction.id),
        )
        : IconButton(
          color: Theme.of(context).errorColor,
          icon: const Icon(Icons.delete),
          onPressed: () => deleteTransactionHandler(transaction.id),
        ),
      ),
    );
  }
}
