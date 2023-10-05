class Result {
  ResultState<dynamic>? state;

  Result({this.state});
}

class ResultState<T> {
  final T state;

  ResultState(this.state);
}

class Loading extends ResultState<bool> {
  bool isLoading;

  Loading(this.isLoading) : super(isLoading);
}

class Success<T> extends ResultState<T> {
  Success(super.state);
}

class Failure extends ResultState<Exception> {
  final Exception exception;

  Failure(this.exception) : super(exception);
}
