import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/models/view_states.dart';

class BaseProvider<T extends Object> extends StateNotifier<ViewState> {
  BaseProvider() : super(InitialViewState());

  void setInitialViewState() {
    state = InitialViewState();
  }

  void setErrorState(String message) {
    debugPrint(message);
    state = ErrorViewState(errorMessage: message);
  }

  void setLoadingState() {
    state = LoadingViewState();
  }

  void setLoadedState(T loadedState) {
    state = LoadedViewState(loadedState);
  }

  void setLoadingMoreState(T loadedState) {
    state = LoadedViewState(loadedState);
  }

  void setEmptyState() {
    state = EmptyViewState();
  }
}
