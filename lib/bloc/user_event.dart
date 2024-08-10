import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUsers extends UserEvent {
  final int page;
  final int perPage;

  const FetchUsers({required this.page, required this.perPage});

  @override
  List<Object> get props => [page, perPage];
}
