import 'package:app_despesas/components/chart.dart';
import 'package:app_despesas/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../models/transaction.dart';
import 'components/transaction_list.dart';


main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
        final ThemeData tema = ThemeData();
     Color c1 = const Color((0x5f3711)).withOpacity(1);
     Color c2 = const Color((0xd4c098)).withOpacity(1);
    return MaterialApp(
      home: MyHomePage(),
          theme: tema.copyWith(
            colorScheme: tema.colorScheme.copyWith(
              primary: c1,
              secondary: c2,
            ),
            textTheme: tema.textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction>_transactions = [];

  List<Transaction> get _recentTransactions{
    return _transactions.where((tr) {//where ou filter, é muito comum
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),//pega data de agora, subtrai 7 dias, se estiver nos últimos 7 dias essa transação precisa estar na lista final
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(), //forma de gerar um valor aleatório
      title: title,
      value: value,
      date: date,
    );
    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id){
    setState(() {
      _transactions.removeWhere((tr){
        return tr.id == id;
      });
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas pessoais'),
        actions: [
          IconButton(
              onPressed: () => _openTransactionFormModal(context),
              icon: Icon(
                Icons.add,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(_transactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
