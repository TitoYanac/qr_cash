import 'package:flutter/material.dart';
import '../../../../../domain/constants/language_constants.dart';
import '../../../../../domain/models/user/person.dart';
import '../../../../../domain/models/user/user.dart';
import '../../../../../main.dart';
import '../../../../core/util/language.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({
    super.key,
    required this.person,
  });
  final Person person;
  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  Language? selectedLanguage;
  late Person auxPerson;
  @override
  void initState() {
    auxPerson = widget.person;
    super.initState();
  }
  @override
  void didUpdateWidget(covariant LanguageSelector oldWidget) {
    auxPerson = widget.person;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(top: 12),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(width: 2, color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(6),
              ),
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  auxPerson.language == "" ?
                  const Icon(Icons.language):
                  Text((Language.languageList().where((element) => element.languageCode == auxPerson.language)).first.flag),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(translation(context)!.language),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                  ),
                ],
              ),
            ),
            Opacity(
              opacity: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<Language>(
                  //value: selectedLanguage, // Asigna el valor seleccionado al DropdownButton
                  iconSize: 30,
                  alignment: Alignment.centerRight,
                  //underline: const SizedBox(),
                  hint: Text(translation(context)!.language),
                  onChanged: (Language? language) async {
                    if (language != null) {
                      widget.person.language = language.languageCode;
                      await setLocale(language.languageCode).then((value) {
                        MyApp.setLocale(context, value);
                      });
                    } else {
                      widget.person.language =
                          User.getInstance().personData!.language;
                    }
                  },
                  items: Language.languageList()
                      .map<DropdownMenuItem<Language>>(
                        (entry) => DropdownMenuItem<Language>(
                          value: entry, // Asigna el objeto Language como valor

                          child: Row(
                            children: [
                              Text(
                                entry.flag,
                                style: const TextStyle(fontSize: 30),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                entry.name,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
