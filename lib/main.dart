
import 'dart:ui';

import 'package:Complete_Guide/models/Transaction.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter/services.dart';
import './widgets/transaction_LIst.dart';
import './widgets/New-Transaction.dart';
import './widgets/chart.dart';

void main() {
  //SystemChrome.setPreferredOrientations([
  //  DeviceOrientation.portraitUp,
  //  DeviceOrientation.portraitDown
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutterapp',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.cyanAccent,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            // ignore: deprecated_member_use
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
            button: TextStyle(color: Colors.white)),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userlist = [];

  List<Transaction> get _resentTransactions {
    return _userlist.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _deleteTransaction(String idd) {
    setState(() {
      _userlist.removeWhere((tx) => tx.id == idd);
    });
  }

  void _addNwetranaction(String protitle, double proamount, DateTime datte) {
    final newtr = Transaction(
      title: protitle,
      amount: proamount,
      date: datte,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userlist.add(newtr);
    });
  }

  void _startAddNewTransaction(BuildContext cxt) {
    showModalBottomSheet(
        context: cxt,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTranaction(_addNwetranaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  bool _showChart = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuryvaraible =MediaQuery.of(context);
    final islandscape =
      mediaQuryvaraible.orientation == Orientation.landscape;
    final apppar = AppBar(
      title: Text(
        'My App',
        style: TextStyle(fontFamily: 'OpenSans'),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );
    var listwidget = Container(
      height: (MediaQuery.of(context).size.height -
              apppar.preferredSize.height -
           mediaQuryvaraible.padding.top) *
          0.7,
      child: TranactionList(_userlist, _deleteTransaction),
    );
    return Scaffold(
      appBar: apppar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (islandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show chart'),
                  Switch (
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            if (!islandscape)
              Container(
                height: (mediaQuryvaraible.size.height -
                        apppar.preferredSize.height -
                      mediaQuryvaraible.padding.top) *
                    0.3,
                child: Chart(_resentTransactions),
              ),
            if (!islandscape) listwidget,
            if (islandscape)
              _showChart
                  ? Container(
                      height: (mediaQuryvaraible.size.height -
                              apppar.preferredSize.height -
                             mediaQuryvaraible.padding.top) *
                          0.7,
                      child: Chart(_resentTransactions),
                    )
                  : listwidget
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:  FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
