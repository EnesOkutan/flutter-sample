class Result<T> {
  late final bool? isSuccess;
  late final T? value;
  late final Exception? error;

  Result({ this.isSuccess, this.value, this.error });
}