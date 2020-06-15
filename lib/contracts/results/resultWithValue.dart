import './result.dart';

class ResultWithValue<T> extends Result {
  T value;
  ResultWithValue(bool isSuccess, T value, String errorMessage)
      : super(isSuccess, errorMessage) {
    this.value = value;
  }
}
