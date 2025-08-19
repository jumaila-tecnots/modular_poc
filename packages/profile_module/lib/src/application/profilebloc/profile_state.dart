part of 'profile_bloc.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    required bool isLoading,
    required bool isError,
    required bool isSuccess,
    required List<ProfileEntity> posts,
    required String message,
}) = _ProfileState;

factory ProfileState.initial(){
  return const ProfileState(
    isLoading: true,
    isError: false,
    isSuccess: false,
    message: '',
    posts: []);
}
}
