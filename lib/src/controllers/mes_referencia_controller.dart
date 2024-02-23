import 'package:flutter/material.dart';

class MesReferenciaController extends ChangeNotifier {
  int _current = DateTime.now().month;

  int get current => _current;
  
  set current(value) {
    _current = value;
  }
}