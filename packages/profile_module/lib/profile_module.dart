import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:module_manager/module_manager.dart';
import 'package:profile_module/profile_screen.dart';

class ProfileModule implements Module {
  @override
  void registerDependencies(GetIt locator) {
    // Register dependencies
  }

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      '/profile': (context) => const ProfileScreen(),
    };
  }
}