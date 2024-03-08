class Value<T> {
  T value;
  Value(this.value);

  @override
  String toString() => value.toString();

  @override
  int get hashCode => value.hashCode;

  @override
  operator ==(covariant Value<T> other) {
    return identical(this, other) && value == other.value;
  }
}

Value<T> useValue<T>(T init) {
  return Value<T>(init);
}
