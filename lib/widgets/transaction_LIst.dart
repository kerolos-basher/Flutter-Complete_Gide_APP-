import 'dart:math';
import 'package:Complete_Guide/models/Transaction.dart';
import 'package:flutter/material.dart';
import '../models/Transaction.dart';

import 'package:intl/intl.dart';

class TranactionList extends StatefulWidget {
  final List<Transaction> userlist;
  final Function deleteTransaction;
  TranactionList(this.userlist, this.deleteTransaction);

  @override
  _TranactionListState createState() => _TranactionListState();
}

class _TranactionListState extends State<TranactionList> {
  Color _bgcolor;
  @override
  void initState() {
    const avalableColor = [
      Colors.blue,
      Colors.red,
      Colors.teal,
      
      Colors.green,
      Colors.tealAccent
    ];
    _bgcolor = avalableColor[Random().nextInt(5)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.userlist.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constans) {
                return Column(
                  children: <Widget>[
                    // ignore: deprecated_member_use
                    Text(
                      'no tranaction added yet !',
                      // ignore: deprecated_member_use
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: constans.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _bgcolor,
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                          child: Text(
                              '\$${widget.userlist[index].amount.toStringAsFixed(2)}'),
                        ),
                      ),
                    ),
                    // ignore: deprecated_member_use
                    title: Text(
                      widget.userlist[index].title,
                      // ignore: deprecated_member_use
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd().format(widget.userlist[index].date),
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    trailing: MediaQuery.of(context).size.width > 400
                        ? FlatButton.icon(
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),
                            textColor: Theme.of(context).errorColor,
                            onPressed: () => widget
                                .deleteTransaction(widget.userlist[index].id),
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => widget
                                .deleteTransaction(widget.userlist[index].id),
                          ),
                  ),
                );
              },
              itemCount: widget.userlist.length,
            ),
    );
  }
}

/* Card(
            
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColorDark)),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(
                    '\$${userlist[index].amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      userlist[index].title,
                      // ignore: deprecated_member_use
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(
                      DateFormat.yMMMMd().format(userlist[index].date),
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
          );
          */
