enum ApiResponseStatus {
  unknownError(null),
  ok(200),
  created(201),
  badResponse(400),
  unauthorized(401),
  serverError(500);

  final int? code;

  const ApiResponseStatus(this.code);
}