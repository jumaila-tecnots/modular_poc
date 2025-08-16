library profile_module;

import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:module_manager/module_manager.dart';
import 'package:profile_module/core/network/dio_client.dart';
import 'package:profile_module/core/network/user_service.dart';
import 'package:profile_module/src/data/datasources/users_datasource.dart';
import 'package:profile_module/src/data/repositories/user_repository_impl.dart';
import 'package:profile_module/src/domain/repositories/users_repository.dart';
import 'package:profile_module/src/domain/usecases/users_usecase.dart';
import 'package:profile_module/src/presentation/bloc/users_cubit.dart';
import 'package:profile_module/src/presentation/users_page.dart';
import 'package:provider/provider.dart';

export 'src/presentation/users_page.dart';

class ProfileModule implements Module {
  @override
  void registerDependencies(GetIt locator) {
    locator.registerLazySingleton<Dio>(() => buildClient());
    locator.registerLazySingleton<UserService>(() => UserService(locator()));
    locator.registerFactory<UsersCubit>(() => UsersCubit(locator()));
    locator.registerFactory<UsersUsecase>(() => UsersUsecase(locator()));
    locator.registerFactory<UsersRepository>(() => UserRepositoryImpl(locator()));
    locator.registerFactory<UsersDataSource>(() => UsersDataSource(locator()));
  }

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      '/users': (context) => ChangeNotifierProvider(

        create: (BuildContext context) {  },
        child: BlocProvider(
          create: (context) => ModuleManager().locator<UsersCubit>()..fetchUsers(),
          child: const UsersPage(),
        ),
      ),
    };
  }
}
