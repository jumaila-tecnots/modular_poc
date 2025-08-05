import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modular_poc/theme.dart';
import 'package:module_manager/module_manager.dart';
import 'package:counter_module/counter_module.dart' as counter;
import 'package:todo_module/todo_module.dart' as todo;

import 'core/utils/theme_service.dart';
import 'injection_container/injectable.dart';
import 'shell_screen.dart';

// Factory map to create module instances
final Map<String, Module Function()> moduleFactories = {
  'CounterModule': () => counter.CounterModule(),
  'TodoModule': () => todo.TodoModule(),

};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();

  final moduleManager = ModuleManager();

  const mockJson = '''
  [{"name": "Posts", "route": "/posts", "moduleClass": "CounterModule"},
    
    {"name": "To-Do", "route": "/todo", "moduleClass": "TodoModule"}
  
  ]
  ''';


  final moduleData = jsonDecode(mockJson) as List<dynamic>;

  // Dynamically register modules
  for (var module in moduleData) {
    final moduleClass = module['moduleClass'] as String;
    final moduleFactory = moduleFactories[moduleClass];
    if (moduleFactory != null) {
      final moduleInstance = moduleFactory();
      moduleManager.registerModule(moduleInstance);
    } else {
      debugPrint('Warning: No module factory found for $moduleClass');
    }
  }

  runApp(MyApp(moduleData: moduleData));
}

class MyApp extends StatelessWidget {
  final List<dynamic> moduleData;

  const MyApp({super.key, required this.moduleData});

  @override
  Widget build(BuildContext context) {
    final modules = moduleData.map((module) {
      return {
        'name': module['name'] as String,
        'route': module['route'] as String,
      };
    }).toList();

    return ChangeNotifierProvider.value(
      value: getIt<ThemeServiceProvider>(),
      child: Consumer<ThemeServiceProvider>(
        builder: (context, themeService, child) {
          return MaterialApp(
            title: 'Modular Clean App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
            home: ShellScreen(modules: modules),
            onGenerateRoute: ModuleManager().generateRoute, // Ensure route generation
          );
        },
      ),
    );
  }
}