import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'user_event.dart';
import 'user_state.dart';
import '../models/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  static const _baseUrl = 'https://reqres.in/api/users';
  int _currentPage = 1;
  List<User> _users = [];
  int _totalPages = 1;

  UserBloc() : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    if (event.page == 1) {
      _currentPage = 1;
      _users = [];
    } else {
      _currentPage = event.page;
    }

    emit(UserLoading(
        users: _users, currentPage: _currentPage, totalPages: _totalPages));

    try {
      final response = await http.get(Uri.parse(
          '$_baseUrl?page=${_currentPage}&per_page=${event.perPage}'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> data = responseData['data'];
        _totalPages = responseData['total_pages'];
        final List<User> users =
            data.map((json) => User.fromJson(json)).toList();

        if (event.page == 1) {
          _users = users;
        } else {
          _users.addAll(users);
        }

        emit(UserLoaded(
            users: _users, currentPage: _currentPage, totalPages: _totalPages));
      } else {
        emit(UserError("Failed to fetch users"));
      }
    } catch (e) {
      emit(UserError("Failed to fetch users"));
    }
  }
}
