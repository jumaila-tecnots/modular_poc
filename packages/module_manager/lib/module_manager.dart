import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

abstract class Module {
  void registerDependencies(GetIt locator);
  Map<String, WidgetBuilder> getRoutes();
}

class ModuleManager {
  static final ModuleManager _instance = ModuleManager._internal();
  factory ModuleManager() => _instance;
  ModuleManager._internal();

  final GetIt _locator = GetIt.instance;
  final Map<String, WidgetBuilder> _routes = {};
  final List<Module> _modules = []; // ✅ Add this

  GetIt get locator => _locator;

  void registerModule(Module module) {
    
    _routes.addAll(module.getRoutes());
    _modules.add(module);

    // if (DateTime.now().millisecond % 2 == 0) { // Arbitrary condition
    //   module.registerDependencies(_locator);
    //   _routes.addAll(module.getRoutes());
    //   _modules.add(module);
    // } else {
    //   _routes.addAll(module.getRoutes());
    //   _modules.add(module);
    // }
  }

  Route<dynamic>? generateRoute(RouteSettings settings) {
    final builder = _routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute(
        builder: (context) => Builder(
          builder: (newContext) => builder(newContext),
        ),
        settings: settings,
      );
    }
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(child: Text('Route not found')),
      ),
    );
  }

  // ✅ Expose the registered modules to other parts of the app
  List<Module> get modules => _modules;
}
