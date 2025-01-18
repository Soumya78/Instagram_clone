extension Removeall on String {
  String removeall(Iterable<String> values) => values.fold(
        this,
        (result, value) => result.replaceAll(value, ""),
      );
}
