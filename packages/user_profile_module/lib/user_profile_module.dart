library user_profile_module;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:module_manager/module_manager.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';

import 'core/network/network.dart';
import 'core/network/network_info.dart';

class UserProfileModule implements Module {
  @override
  void registerDependencies(GetIt locator) {
    locator.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(Connectivity()));
    locator.registerLazySingleton<NetworkService>(
        () => HttpNetworkService(locator<NetworkInfo>()));
  }

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      '/user-profile': (context) => ChangeNotifierProvider(
            create: (context) {},
            child: BlocProvider(
              create: (context) => ModuleManager().locator<UserProfileBloc>()
                ..add(const UserProfileEvent.getUserProfiles()),
              child: UserProfilePage(),
            ),
          ),
    };
  }
}
