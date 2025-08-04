import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Navigate to a named route using GoRouter
  void navigateToNamed(String routeName, {Map<String, String>? params}) {
    if (navigatorKey.currentContext != null) {
      navigatorKey.currentContext!.goNamed(routeName, pathParameters: params ?? {});
    }
  }

  // Push a new named route (keeps history)
  void pushToNamed(String routeName, {Map<String, String>? params}) {
    if (navigatorKey.currentContext != null) {
      navigatorKey.currentContext!.pushNamed(routeName, pathParameters: params ?? {});
    }
  }

  // Replace the current route with a new one
  void replaceWithNamed(String routeName, {Map<String, String>? params}) {
    if (navigatorKey.currentContext != null) {
      navigatorKey.currentContext!.goNamed(routeName, pathParameters: params ?? {});
    }
  }

  // Go back in navigation stack
  void goBack() {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop();
    }
  }
}
