import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qrcash/domain/models/business/business.dart';
import 'package:qrcash/domain/models/user/user.dart';
import 'package:qrcash/presentation/features/auth/bloc/bloc_timer.dart';
import 'package:qrcash/presentation/features/auth/pages/user_otp_receiver_forgot_pass_page.dart';
import 'package:qrcash/presentation/features/business/bloc/bloc_business.dart';
import 'package:qrcash/presentation/features/business/bloc/bloc_business_state.dart';
import 'package:qrcash/presentation/features/user/bloc/bloc_user.dart';
import 'package:qrcash/presentation/features/user/bloc/bloc_user_state.dart';
import 'data/datasources/local/shared_preferences_data_source.dart';
import 'domain/constants/language_constants.dart';

import 'presentation/features/bloc/btn/bloc_btn_state.dart';
import 'presentation/features/bloc/btn/bloc_btn.dart';
import 'presentation/features/bloc/status/bloc_status_text.dart';
import 'presentation/features/bloc/status/bloc_status_text_state.dart';
import 'presentation/features/business/bloc/bloc_bottom_navigation_bar_state.dart';
import 'presentation/features/business/bloc/my_bloc_bottom_navigation_bar.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(120, 130, 130, 1),
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocStatusText>(
          lazy: false,
          create: (BuildContext context) => BlocStatusText(const StatusTextState(statusText: '    ', userLogged: false, statusOnline: false)),
        ),
        BlocProvider<BlocBusiness>(
          create: (BuildContext context) => BlocBusiness(BlocBusinessState(Business.getInstance())),
        ),
        BlocProvider<BlocUser>(
          create: (BuildContext context) => BlocUser(BlocUserState(User.getInstance())),
        ),
        BlocProvider<MyBlocBtn>(
          create: (BuildContext context) => MyBlocBtn(const MyStateBtn(statusButton: 0)),
        ),
        BlocProvider<MyBlocBottomNavigationBar>(
          create: (BuildContext context) => MyBlocBottomNavigationBar(MyBottomNavigationBarState(0)),
        ),
      ],
      child: MaterialApp(
        title: 'QR Cash',
        debugShowCheckedModeBanner: false,
        theme: _themeData(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        locale: _currentLocale, // Use the stored or default language
        supportedLocales: AppLocalizations.supportedLocales,
        home: const SplashScreen(),
        /*home: BlocProvider(
          create: (context) => TimerBloc(),
          child: const UserOtpReceiverForgotPassPage(
            number: '123456789',
            codeOTP: '123456',
          ),
        ),*/
      ),
    );

  }
}

_themeData() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      primary: const Color.fromRGBO(16, 95, 167, 1),
      //secondary: const Color.fromRGBO(225, 11, 26, 1),
      secondary: Colors.red,
      tertiary: const Color.fromRGBO(120, 130, 130, 1),
      shadow: const Color.fromRGBO(138, 143, 121, 0.08),
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
