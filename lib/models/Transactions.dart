import 'package:flutter/foundation.dart';
class Transaction{
  double value;
  String id;
  String title;
  DateTime date;

  Transaction({
     @required this.id,
     @required this.value,
     @required this.date,
     @required this.title});


}