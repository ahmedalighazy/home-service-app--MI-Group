class OtpBtnData {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;

  const OtpBtnData({
    required this.isLoading,
    required this.isSuccess,
    required this.isError,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OtpBtnData &&
          isLoading == other.isLoading &&
          isSuccess == other.isSuccess &&
          isError == other.isError;

  @override
  int get hashCode => Object.hashAll([isLoading, isSuccess, isError]);
}
