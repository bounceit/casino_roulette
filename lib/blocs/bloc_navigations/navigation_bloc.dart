import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc()
      : super(
          const NavigationState(),
        ) {
    on<NavigateMenu>((event, emit) {
      emit(
        state.copyWith(
          status: NavigationStateStatus.menu,
          currentIndex: event.menuIndex,
          route: event.route,
        ),
      );
    });

    on<NavigateTab>((event, emit) {
      emit(
        state.copyWith(
          status: NavigationStateStatus.tab,
          currentIndex: event.tabIndex,
          route: event.route,
        ),
      );
    });
  }
}
