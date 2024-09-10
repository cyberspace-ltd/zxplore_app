// ignore_for_file: public_member_api_docs

class AppException implements Exception {
  String? message;

  AppException(this.message);

  @override
  String toString() {
    return message!;
  }
}
