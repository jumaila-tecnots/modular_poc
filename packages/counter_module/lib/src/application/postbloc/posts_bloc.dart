// packages/counter_module/src/application/postbloc/posts_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/main_failure.dart';
import '../../domain/entities/posts_entity.dart';
import '../../domain/usecases/posts_usecase.dart';

part 'posts_event.dart';
part 'posts_state.dart';
part 'posts_bloc.freezed.dart';

@Injectable()
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsUseCase getPostsUseCase;
  StreamSubscription? _networkSubscription; // Bug: Undisposed subscription

  PostsBloc(this.getPostsUseCase) : super(PostsState.initial()) {
    on<_GetPosts>(_onGetPosts);

    _networkSubscription = Stream.periodic(Duration(seconds: 5)).listen((_) {
      print('Network status check'); // Simulate network monitoring
    });
  }

  void _onGetPosts(_GetPosts event, Emitter<PostsState> emit) async {
    emit(state.copyWith(isLoading: true));
    final Either<MainFailure, List<PostEntity>> postsOptions = await getPostsUseCase();
    emit(postsOptions.fold(
          (failure) => state.copyWith(isLoading: false, isError: true, isSuccess: false, message: failure.message),
          (success) => state.copyWith(isLoading: false, isError: false, isSuccess: true, posts: success),
    ));
  }

  @override
  Future<void> close() {
    _networkSubscription?.cancel();
    return super.close();
  }
}