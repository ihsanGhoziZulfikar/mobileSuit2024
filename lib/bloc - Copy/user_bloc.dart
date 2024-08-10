import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'user_event.dart';
import 'user_state.dart';
import '../models/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final response = await http
          .get(Uri.parse('https://reqres.in/api/users?page=1&per_page=10'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        final List<User> users =
            data.map((json) => User.fromJson(json)).toList();
        emit(UserLoaded(users));
      } else {
        emit(const UserError("Failed to fetch users"));
      }
    } catch (e) {
      emit(const UserError("Failed to fetch users"));
    }
  }
}
