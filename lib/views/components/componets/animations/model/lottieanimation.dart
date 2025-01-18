enum LottieAnimation {
  datanotfound(name: 'data_not_found'),
  empty(name: 'empty'),
  loading(name: 'loading'),
  error(name: 'error'),
  smallerror(name: 'small_error');

  final String name;
  const LottieAnimation({required this.name});
}
