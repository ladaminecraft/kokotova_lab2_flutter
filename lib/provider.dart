import 'package:flutter/material.dart';
import 'second.dart';

class Prov with ChangeNotifier{
  String _name = '';
  bool _read = false;

  String get name => _name;
  bool get read => _read;

  void change(String fan) {
    _name = fan;
    _read = !_read;
     notifyListeners();
    
  }
}