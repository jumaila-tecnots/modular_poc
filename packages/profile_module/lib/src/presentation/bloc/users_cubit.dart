import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_module/core/usecase/usecase.dart';
import 'package:profile_module/src/domain/usecases/users_usecase.dart';
import 'package:profile_module/src/presentation/bloc/users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UsersUsecase usersUsecase;
  UsersCubit(this.usersUsecase) : super(InitialState());

  Future<void> fetchUsers() async {
    emit(LoadingState());
    try {
      final res = await usersUsecase(NoParams());
      res.fold(
            (failure) => emit(ErrorState(message: failure.message)),
            (users) => emit(SuccessState(users: users)),
      );
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}