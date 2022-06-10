abstract class ViewState {}

class InitialViewState implements ViewState {}

class LoadingViewState implements ViewState {}

class ErrorViewState implements ViewState {
  final String errorMessage;

  ErrorViewState({required this.errorMessage});
}

class EmptyViewState implements ViewState {}

class LoadingMoreViewState<T extends Object> implements ViewState {
  final T data;

  LoadingMoreViewState(
    this.data,
  );

  LoadingMoreViewState<T> copyWith({
    T? data,
  }) {
    return LoadingMoreViewState<T>(
      data ?? this.data,
    );
  }

  @override
  String toString() => 'LoadingMoreViewState(data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoadingMoreViewState<T> && other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}

class LoadedViewState<T extends Object> implements ViewState {
  final T data;

  LoadedViewState(
    this.data,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoadedViewState<T> && other.data == data;
  }

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() => 'LoadedViewState(data: $data)';

  LoadedViewState<T> copyWith({
    T? data,
  }) {
    return LoadedViewState<T>(
      data ?? this.data,
    );
  }
}
