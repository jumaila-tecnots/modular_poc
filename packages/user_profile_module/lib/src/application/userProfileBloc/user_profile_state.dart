part of './user_profile_bloc.dart';

@freezed
class UserProfileState with _$UserProfileState {
  const factory UserProfileState({
    required bool isLoading,
    required bool isError,
    required bool isSuccess,
    required List<UserProfileEntity> users,
    required String message,
  }) = _UserProfileState;

  factory UserProfileState.initial() {
    return const UserProfileState(
        isLoading: true,
        isError: false,
        isSuccess: false,
        message: '',
        users: []);
  }
}
