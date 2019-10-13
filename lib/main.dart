import 'package:expenses/models/Transactions.dart' show Transaction;
import 'package:expenses/widgets/new_transacrion.dart';
import 'package:expenses/widgets/transations_list.dart';
import 'package:intl/intl.dart';
import 'widgets/chart.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.deepOrangeAccent,
        fontFamily: 'QuickSand',
        errorColor: Colors.red,
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
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final List<Transaction> _userTransactionss = [
/*     Transaction(date:DateTime.now() 
  ,value: 8  ,id:'1' ,title:'New shoes' ),
    Transaction(date:DateTime.now() 
  ,value: 9  ,id:'2' ,title:'New watch' ),
    Transaction(date:DateTime.now() 
  ,value: 15 ,id:'3' ,title:'New laptop' ),
   */
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactionss.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String titleTx, double amount, DateTime date) {
    final newTx = Transaction(
      title: titleTx,
      value: amount,
      id: DateTime.now().toString(),
      date: date,
    );
    setState(() {
      _userTransactionss.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactionss.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return GestureDetector(
            child: NewTransactions(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    

    final appbar = AppBar(
      title: Text('Flutter App'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
        )
      ],
    );

    final myChart = Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.5,
                    child: Chart(_recentTransactions));

    final myList = Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child:
                        TransationsList(_userTransactionss, _deleteTransaction));


    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[


            if (isLandscape) Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(
                "Show Chart",
              ),
              Switch(
                value: _showChart,
                onChanged: (val) {
                  setState(() {
                    _showChart = val;
                  });
                },
              )
            ]),

            if(!isLandscape) Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.3,
                    child:
                        TransationsList(_userTransactionss, _deleteTransaction)),
            if(!isLandscape) myList
            ,

            if(isLandscape) _showChart
                ? myChart
                : myList
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startAddNewTransaction(context);
        },
      ),
    );
  }
}
