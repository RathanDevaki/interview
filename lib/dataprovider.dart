import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  late String st1 = 'NULL';
  //, st2 = '';
  void add(String s) {
    st1 = s;
    notifyListeners();
  }
}
