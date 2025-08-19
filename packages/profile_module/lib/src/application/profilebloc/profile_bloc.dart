// packages/counter_module/src/application/profilebloc/profile_bloc.dart
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/main_failure.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/usecases/posts_usecase.dart';

part 'profile_bloc.freezed.dart';
part 'profile_state.dart';
part 'profile_event.dart';

@Injectable()
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUseCase getProfileUseCase;
  StreamSubscription? _networkSubscription;

  ProfileBloc(this.getProfileUseCase) : super(ProfileState.initial()) {
    on<_GetProfile>(_onGetProfile);

    _networkSubscription = Stream.periodic(Duration(seconds: 5)).listen((_) {
      if (kDebugMode) {
        print('Network status check');
      } // Simulate network monitoring
    });
  }

  void _onGetProfile(_GetProfile event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    final Either<MainFailure, List<ProfileEntity>> postsOptions =
        await getProfileUseCase();
    emit(postsOptions.fold(
      (failure) => state.copyWith(
          isLoading: false,
          isError: true,
          isSuccess: false,
          message: failure.message),
      (success) => state.copyWith(
          isLoading: false, isError: false, isSuccess: true, posts: success),
    ));
  }
}
