import './resultWithValue.dart';

class ResultWithDoubleValue<T, K> extends ResultWithValue<T> {
  K secondValue;
  ResultWithDoubleValue(
      bool isSuccess, T value, K secondValue, String errorMessage)
      : super(isSuccess, value, errorMessage) {
    this.secondValue = secondValue;
  }
}
