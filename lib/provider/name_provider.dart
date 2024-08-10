import 'package:flutter/material.dart';

class NameProvider with ChangeNotifier {
  String? _name;

  String? get name => _name;

  void inputName(String name) {
    _name = name;
    notifyListeners();
  }
}
