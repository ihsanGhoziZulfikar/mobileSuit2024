import '../models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {
  final List<User> users;
  final int currentPage;

  const UserLoading({required this.users, required this.currentPage});

  @override
  List<Object?> get props => [users, currentPage];
}

class UserLoaded extends UserState {
  final List<User> users;
  final int currentPage;

  const UserLoaded({required this.users, required this.currentPage});

  @override
  List<Object?> get props => [users, currentPage];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}
