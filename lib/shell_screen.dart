import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:module_manager/module_manager.dart';
import 'core/utils/theme_service.dart';

class ShellScreen extends StatefulWidget {
  final List<Map<String, String>> modules;

  const ShellScreen({super.key, required this.modules});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _selectedIndex = 0;
  late Widget _currentScreen;

  @override
  void initState() {
    super.initState();
    _loadModuleScreen(_selectedIndex);
  }

  void _loadModuleScreen(int index) {
    if (index >= widget.modules.length) return; // Prevent index out of bounds
    final routeName = widget.modules[index]['route']!;
    WidgetBuilder? builder;

    // Loop through all registered modules
    for (final module in ModuleManager().modules) {
      final routes = module.getRoutes();
      if (routes.containsKey(routeName)) {
        builder = routes[routeName];
        break;
      }
    }

    setState(() {
      _selectedIndex = index;
      _currentScreen = builder != null
          ? builder(context)
          : const Center(child: Text('Module not found'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // If fewer than 2 modules, show only the module screen or a fallback
    if (widget.modules.length < 2) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Modular Clean App', style: theme.textTheme.titleMedium),
          actions: [
            Switch(
              value: Provider.of<ThemeServiceProvider>(context).isDarkModeOn,
              onChanged: (_) => Provider.of<ThemeServiceProvider>(context, listen: false)
                  .toggleTheme(),
            ),
          ],
        ),
        body: _currentScreen,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Modular Clean App', style: theme.textTheme.titleMedium),
        actions: [
          Switch(
            value: Provider.of<ThemeServiceProvider>(context).isDarkModeOn,
            onChanged: (_) => Provider.of<ThemeServiceProvider>(context, listen: false)
                .toggleTheme(),
          ),
        ],
      ),
      body: _currentScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _loadModuleScreen,
        items: widget.modules
            .map(
              (module) => BottomNavigationBarItem(
            icon: const Icon(Icons.extension),
            label: module['name'],
          ),
        )
            .toList(),
      ),
    );
  }
}