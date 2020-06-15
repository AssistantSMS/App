class Result {
  bool isSuccess;
  bool get hasFailed => !isSuccess;
  String errorMessage;

  Result(this.isSuccess, this.errorMessage);
}
