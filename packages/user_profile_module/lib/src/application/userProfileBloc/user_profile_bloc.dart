import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';
part 'user_profile_bloc.freezed.dart';

@Injectable()
class UserProfileBloc extends Bloc<UserProfilesEvent, UserProfilesState> {
  @override
  Future<void> close() {
    return super.close();
  }
}
