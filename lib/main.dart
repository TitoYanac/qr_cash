import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'data/datasources/local/shared_preferences_data_source.dart';
import 'domain/constants/language_constants.dart';

import 'presentation/bloc/status/bloc_splash_screen.dart';
import 'presentation/core/services/authentication_service.dart';
import 'presentation/features/auth/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      //statusBarColor: Color.fromRGBO(120, 130, 130, 1),
      statusBarColor: Colors.black,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SharedPreferencesDataSource().init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _currentLocale; // Default language
  setLocale(Locale locale) async => setState(() => _currentLocale = locale);

  void didChangeLocales() {
    getLocale().then((languageCode) => setLocale(languageCode));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Save Scan',
      debugShowCheckedModeBanner: false,
      theme: _themeData(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: _currentLocale, // Use the stored or default language
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<BlocSplashScreen>(
        create: (BuildContext contexto) =>
            BlocSplashScreen(AuthenticationService(contexto)),
        child: const SplashScreen(),
      ),
      //home: const LoginScreen(),
    );
  }
}

_themeData() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      primary: const Color.fromRGBO(232, 0, 21, 1),
      //secondary: const Color.fromRGBO(225, 11, 26, 1),
      secondary: const Color.fromRGBO(0, 0, 0, 1),
      tertiary: const Color.fromRGBO(173, 173, 173, 1),
      shadow: const Color.fromRGBO(173, 173, 173, 1),
    ),
    useMaterial3: true,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.red),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                300), // Ajusta el radio según tus necesidades
            side: const BorderSide(
                width: 3.0, color: Colors.grey), // Ancho y color del borde
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24)),
    ),
  );
}
