import '../models/Transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransationsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransationsList(this.transactions ,this.deleteTx );

  @override
  Widget build(BuildContext context) {
    return  transactions.isEmpty
            ? LayoutBuilder(builder: (ctx , constraints){
              return Column(
                children: <Widget>[
                  Text('NO AVAILABLE TRANSACTIONS'),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              );
            })
            : ListView.builder(
                itemBuilder: (ctx, i) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text(
                              '\$ ${transactions[i].value}',
                            ),
                          ),
                        ),
                      ),
                      title: Text(transactions[i].title,
                          style: Theme.of(context).textTheme.title),
                      subtitle:
                          Text(DateFormat.yMMMd().format(transactions[i].date)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed:()=> deleteTx(transactions[i].id),
                      ),
                    ),
                  );
                },
                itemCount: transactions.length,
              );
  }
}
