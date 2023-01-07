import 'package:equatable/equatable.dart';

abstract class AdminMenuEditEvent extends Equatable {
  const AdminMenuEditEvent();

  @override
  List<Object> get props => [];
}

class FetchMenuById extends AdminMenuEditEvent {}

class ClearState extends AdminMenuEditEvent {}
