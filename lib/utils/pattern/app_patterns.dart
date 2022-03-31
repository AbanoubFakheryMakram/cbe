
class AppPatterns {

  //  => email pattern
  static const String _emailPattern = r"^^[a-zA-Z0-9.!#$%&*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";

  static bool emailIsValid(String email) {
    RegExp emailRegularExpression = RegExp(_emailPattern);
    return emailRegularExpression.hasMatch(email.trim());
  }
}