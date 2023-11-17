
class Language{
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);
  
  static List<Language> languageList(){
    return <Language>[
      Language(1, "🇺🇸", "English", "en"), //india
      Language(2, "🇵🇪", "Español", "es"), //india
      Language(3, "🇮🇳", "भारत", "hi"), //india
      Language(4, "🇫🇷", "français", "fr"), //india
      Language(5, "🇨🇳", "中文", "zh"), //india
    ];
  }
}