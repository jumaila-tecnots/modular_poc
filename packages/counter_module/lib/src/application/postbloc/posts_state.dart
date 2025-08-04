part of 'posts_bloc.dart';

@freezed
class PostsState with _$PostsState {
  const factory PostsState({
    required bool isLoading,
    required bool isError,
    required bool isSuccess,
    required List<PostEntity> posts,
    required String message,
}) = _PostsState;

factory PostsState.initial(){
  return const PostsState(
    isLoading: true,
    isError: false,
    isSuccess: false,
    message: '',
    posts: []);
}
}
