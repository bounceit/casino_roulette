import 'package:casino/pages/game_page/game_page.dart';
import 'package:flutter/material.dart';

enum NavigationStateStatus {
  initial,
  menu,
  tab,
}

@immutable
class NavigationState {
  const NavigationState({
    this.status = NavigationStateStatus.initial,
    this.currentIndex = 0,
    this.route = GamePage.routeName,
  });

  final NavigationStateStatus status;
  final int currentIndex;
  final String route;

  NavigationState copyWith({
    NavigationStateStatus? status,
    int? currentIndex,
    String? route,
  }) {
    return NavigationState(
      status: status ?? this.status,
      currentIndex: currentIndex ?? this.currentIndex,
      route: route ?? this.route,
    );
  }
}
