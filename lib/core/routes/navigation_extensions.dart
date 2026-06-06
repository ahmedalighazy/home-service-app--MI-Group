import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Navigation Extensions for backward compatibility
/// Provides Navigator-like methods using GoRouter under the hood
extension NavigationExtensions on BuildContext {
  /// Push named route with optional arguments
  void pushNamed(String routeName, {Object? arguments}) {
    go(routeName, extra: arguments);
  }

  /// Push replacement named route with optional arguments
  void pushReplacementNamed(String routeName, {Object? arguments}) {
    pushReplacement(routeName, extra: arguments);
  }

  /// Push named and remove until with optional arguments
  void pushNamedAndRemoveUntil(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    // With GoRouter, we use go() which replaces the entire stack
    go(routeName, extra: arguments);
  }
}

/// Extension on NavigatorState for backward compatibility
extension NavigatorStateExtensions on NavigatorState {
  /// Push named route with optional arguments
  void pushNamed(String routeName, {Object? arguments}) {
    context.go(routeName, extra: arguments);
  }

  /// Push replacement named route with optional arguments
  void pushReplacementNamed(String routeName, {Object? arguments}) {
    context.pushReplacement(routeName, extra: arguments);
  }

  /// Push named and remove until with optional arguments
  void pushNamedAndRemoveUntil(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    context.go(routeName, extra: arguments);
  }
}
