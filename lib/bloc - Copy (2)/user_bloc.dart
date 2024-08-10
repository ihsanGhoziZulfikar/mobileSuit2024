import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'user_event.dart';
import 'user_state.dart';
import '../models/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  static const _baseUrl = 'https://reqres.in/api/users';
  int _currentPage = 1;
  final int _perPage = 10;
  List<User> _users = [];

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

    emit(UserLoading(users: _users, currentPage: _currentPage));

    try {
      final response = await http
          .get(Uri.parse('$_baseUrl?page=$_currentPage&per_page=$_perPage'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        final List<User> users =
            data.map((json) => User.fromJson(json)).toList();

        if (event.page == 1) {
          _users = users;
        } else {
          _users.addAll(users);
        }

        emit(UserLoaded(users: _users, currentPage: _currentPage));
      } else {
        emit(UserError("Failed to fetch users"));
      }
    } catch (e) {
      emit(UserError("Failed to fetch users"));
    }
  }
}
