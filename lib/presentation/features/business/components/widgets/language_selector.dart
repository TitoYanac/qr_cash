import 'package:flutter/material.dart';
import '../../../../../domain/constants/language_constants.dart';
import '../../../../../domain/models/user/person.dart';
import '../../../../../domain/models/user/user.dart';
import '../../../../../main.dart';
import '../../../../util/language.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({
    Key? key,
    required this.person,
  }) : super(key: key);
  final Person person;
  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  Language? selectedLanguage;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.only(top: 12),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(6),
            ),
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.language),
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
    );
  }
}
