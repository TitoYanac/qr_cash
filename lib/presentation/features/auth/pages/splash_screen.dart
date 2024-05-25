import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_save_scan/presentation/features/auth/pages/login_screen.dart';
import 'package:qr_save_scan/presentation/widgets/atoms/text_atom.dart';

import '../../../bloc/status/bloc_splash_screen.dart';
import '../../../core/services/navigation_service.dart';
import 'auth_captcha_validator_page.dart';
import 'auth_no_internet_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BlocSplashScreen>(context).triggerValidations();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    double pagewidth = MediaQuery.of(context).size.width;
    double pageheight = MediaQuery.of(context).size.height;
    double minSize = min(pagewidth, pageheight);
    double squareSide = minSize * 0.35;
    double bottomPosition = min(pagewidth, pageheight) * 0.5;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromRGBO(227, 0, 20, 1),
                Color.fromRGBO(191, 0, 10, 1)
              ])),
            ),
          ),
          Center(
            child: SizedBox(
              width: squareSide,
              height: squareSide,
              child: SvgPicture.asset(
                "assets/icons/ic_launcher.svg",
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.background,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: bottomPosition,
            child: Container(
              width: pagewidth,
              height: squareSide,
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: BlocConsumer<BlocSplashScreen, SplashScreenState>(
                    listener: (context, state) async {
                  final nextPage = state is SplashScreenUserLoggedState
                      ? const AuthCaptchaValidatorPage()
                      : state is SplashScreenUserNotLoggedState
                          ? const LoginScreen()
                          : state is SplashScreenErrorState
                              ? const AuthNoInternetScreen()
                              : null;
                  await Future.delayed(const Duration(seconds: 2));
                  if (nextPage != null) {
                    navigateToAndRemove(context, nextPage);
                  }
                }, builder: (context, state) {
                  return TextAtom(
                    text: state.message,
                    color: Theme.of(context).colorScheme.background,
                    align: TextAlign.center,
                  );
                }),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: squareSide*0.8,
                    height: squareSide*0.8,
                    color: Colors.transparent,
                    child: SvgPicture.asset(
                      "assets/icons/logo_listoil.svg",
                      fit: BoxFit.contain,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.background,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToAndRemove(BuildContext context, Widget nextPage) {
    NavigationService().navigateToAndRemoveUntil(context, nextPage);
  }
}
