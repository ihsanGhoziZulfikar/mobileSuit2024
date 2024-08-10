import 'package:flutter/material.dart';
import '../models/user_model.dart';

class SelectedUserProvider with ChangeNotifier {
  User? _selectedUser;

  User? get selectedUser => _selectedUser;

  void selectUser(User user) {
    _selectedUser = user;
    notifyListeners();
  }
}
