import 'package:equatable/equatable.dart';
import 'package:profile_module/src/domain/entities/user_entity.dart';

abstract class UsersState extends Equatable {
  const UsersState();
}

class InitialState extends UsersState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends UsersState {
  @override
  List<Object?> get props => [];
}

class SuccessState extends UsersState{
  final List<UserEntity> users;
  const SuccessState({required this.users});

  @override
  List<Object?> get props => [users];
}

class ErrorState extends UsersState {
  final String message;
  const ErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}