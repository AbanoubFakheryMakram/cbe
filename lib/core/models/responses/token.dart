class Token {
  Token({
    required this.accessToken,
    required this.refreshToken,
    required this.expireAt,
  }) {
    dateTimeUtcOfSaveToken = DateTime.now().toUtc().toString();
  }

  late String dateTimeUtcOfSaveToken;
  String? accessToken;
  String? refreshToken;
  int? expireAt;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        expireAt: json["expireAt"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "expireAt": expireAt,
      };

  bool shouldRefreshTokenAt(DateTime dateTimeUtc) {
    var date = DateTime.parse(dateTimeUtcOfSaveToken);
    var dateToRefreshTokenAt = date.add(Duration(seconds: expireAt ?? 0));
    if (dateTimeUtc.isAfter(dateToRefreshTokenAt)) return true;
    return false;
  }
}
