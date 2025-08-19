library counter_module;

import 'package:counter_module/core/utils/theme_service.dart';
import 'package:counter_module/src/application/post_page.dart';
import 'package:counter_module/src/application/postbloc/posts_bloc.dart';
import 'package:counter_module/src/data/datsources/posts_remote_datasource.dart';
import 'package:counter_module/src/data/repositories/posts_repository.dart';
import 'package:counter_module/src/domain/repositories/i_post_repo.dart';
import 'package:counter_module/src/domain/usecases/posts_usecase.dart';
import 'package:counter_module/core/network/network.dart';
import 'package:counter_module/core/network/network_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:module_manager/module_manager.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';

export 'src/application/post_page.dart';

class CounterModule implements Module {
  @override
  void registerDependencies(GetIt locator) {
    locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));
    locator.registerLazySingleton<NetworkService>(() => HttpNetworkService(locator<NetworkInfo>()));
    locator.registerLazySingleton<PostRemoteDataSource>(
          () => PostRemoteDatasourceImpl(networkService: locator<NetworkService>()),
    );
    locator.registerLazySingleton<IPostsRepo>(
          () => PostsRepository(remoteDataSource: locator<PostRemoteDataSource>()),
    );
    locator.registerLazySingleton<PostsUseCase>(
          () => PostsUseCase(postsRepo: locator<IPostsRepo>()),
    );

    /// ✅ Register Bloc as factory instead of singleton
    locator.registerLazySingleton<PostsBloc>(
          () => PostsBloc(locator<PostsUseCase>()),
    );
  }

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      '/posts': (context) => ChangeNotifierProvider(
        create: (BuildContext context) {  },
        child: BlocProvider(
          create: (context) =>
          ModuleManager().locator<PostsBloc>()..add(const PostsEvent.getPosts()),
          child: const PostPage(),
        ),
      ),
    };
  }
}
