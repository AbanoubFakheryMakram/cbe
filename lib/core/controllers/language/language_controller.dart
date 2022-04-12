abstract class LanguageController {
  String changeLanguage(String langCode);
  void saveNewLanguage(String langCode);
  Future<String> loadLanguage();
  String getLangCode();
}