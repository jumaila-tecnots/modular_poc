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
  Widget? _currentScreen;

  late ThemeServiceProvider themeServiceProvider;

  @override
  void initState() {
    super.initState();
    themeServiceProvider = context.read<ThemeServiceProvider>();
    _loadModuleScreen(_selectedIndex);
  }

  @override
  void didUpdateWidget(ShellScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadModuleScreen(_selectedIndex); // Ensure state is preserved
  }

  void _loadModuleScreen(int index) {
    if (index >= widget.modules.length) return; // Prevent index out of bounds

    _selectedIndex = index;
    final routeName = widget.modules[index]['route']!;

    // Loop through all registered modules
    for (final module in ModuleManager().modules) {
      final routes = module.getRoutes();
      if (routes.containsKey(routeName)) {
        _currentScreen = routes[routeName]!(context);
        break;
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Modular Clean App', style: theme.textTheme.titleMedium),
          actions: [
            Switch(
              value: themeServiceProvider.isDarkModeOn,
              onChanged: (_) => themeServiceProvider.toggleTheme(),
            ),
          ],
        ),
        body: _currentScreen,
        // If fewer than 2 modules, show only the module
        bottomNavigationBar: (widget.modules.length >= 2)
            ? BottomNavigationBar(
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
              )
            : null);
  }
}
