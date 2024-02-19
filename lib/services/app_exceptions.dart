class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix $_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, " ");
}

class NoDataException extends AppException {
  NoDataException([message])
      : super(
    message,
    "The request was successful, but the response has no content.",
  );
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "BadRequest.");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised.");
}

class ResoruceNotFoundException extends AppException {
  ResoruceNotFoundException([message]) : super(message, "ResoruceNotFound.");
}

class UnsupportedMediaTypeException extends AppException {
  UnsupportedMediaTypeException([message])
      : super(message, "UnsupportedMediaType.");
}

class UnprocessableEntityException extends AppException {
  UnprocessableEntityException([message])
      : super(message, "UnprocessableEntity.");
}

class InternalServerErrorException extends AppException {
  InternalServerErrorException([message])
      : super(message, "InternalServerError.");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, " ");
}
