library profile_module;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:module_manager/module_manager.dart';
import 'package:profile_module/core/network/network.dart';
import 'package:profile_module/core/network/network_info.dart';
import 'package:provider/provider.dart';

import 'profile_module.dart';
import 'src/application/profilebloc/profile_bloc.dart';
import 'src/data/datsources/profile_remote_datasource.dart';
import 'src/data/repositories/profile_repository.dart';
import 'src/domain/repositories/i_profile_repo.dart';
import 'src/domain/usecases/posts_usecase.dart';

export 'src/application/profile_page.dart';

class ProfileModule implements Module {
  @override
  void registerDependencies(GetIt locator) {
    locator.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(Connectivity()));
    locator.registerLazySingleton<NetworkService>(
        () => HttpNetworkService(locator<NetworkInfo>()));
    locator.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDatasourceImpl(
          networkService: locator<NetworkService>()),
    );
    locator.registerLazySingleton<IProfileRepo>(
      () => ProfileRepository(
          remoteDataSource: locator<ProfileRemoteDataSource>()),
    );
    locator.registerLazySingleton<ProfileUseCase>(
      () => ProfileUseCase(postsRepo: locator<IProfileRepo>()),
    );

    /// ✅ Register Bloc as factory instead of singleton
    locator.registerLazySingleton<ProfileBloc>(
      () => ProfileBloc(locator<ProfileUseCase>()),
    );
  }

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      '/profile': (context) => ChangeNotifierProvider(
            create: (BuildContext context) {},
            child: BlocProvider(
              create: (context) => ModuleManager().locator<ProfileBloc>()
                ..add(const ProfileEvent.getProfile()),
              child: const ProfilePage(),
            ),
          ),
    };
  }
}
