class Success {
  int? code;
  Object? response;
  Success({this.code, this.response});
}

class Failure {
  int? code;
  Object? errResponse;
  Failure({this.code, this.errResponse});
}
