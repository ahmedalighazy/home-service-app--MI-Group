import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension NavigationExtensions on BuildContext {

  void pushNamed(String routeName, {Object? arguments}) {
    GoRouter.of(this).push(routeName, extra: arguments);
  }

  void pushReplacementNamed(String routeName, {Object? arguments}) {
    pushReplacement(routeName, extra: arguments);
  }

  void pushNameddAndRemoveUntil(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {

    go(routeName, extra: arguments);
  }

  void pop() {
    GoRouter.of(this).pop();
  }
}

extension NavigatorStateExtensions on NavigatorState {

  void pushNamed(String routeName, {Object? arguments}) {
    context.go(routeName, extra: arguments);
  }

  void pushReplacementNamed(String routeName, {Object? arguments}) {
    context.pushReplacement(routeName, extra: arguments);
  }

  void pushNameddAndRemoveUntil(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    context.go(routeName, extra: arguments);
  }
}
