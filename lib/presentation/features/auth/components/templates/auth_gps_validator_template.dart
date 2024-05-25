import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_save_scan/domain/constants/language_constants.dart';

import '../../../../bloc/status/bloc_gps_screen.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../widgets/atoms/text_atom.dart';
import '../../../business/pages/home_screen.dart';
import '../../pages/auth_no_internet_screen.dart';

class AuthGpsValidatorTemplate extends StatefulWidget {
  const AuthGpsValidatorTemplate({super.key});

  @override
  State<AuthGpsValidatorTemplate> createState() =>
      _AuthGpsValidatorTemplateState();
}

class _AuthGpsValidatorTemplateState extends State<AuthGpsValidatorTemplate> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BlocGpsScreen>(context).triggerValidations();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    double pagewidth = MediaQuery.of(context).size.width;
    double pageheight = MediaQuery.of(context).size.height;
    double minSize = min(pagewidth, pageheight);
    double squareSide = minSize * 0.4;
    double bottomPosition = min(pagewidth, pageheight) * 0.3;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(227, 0, 20, 1),
                      Color.fromRGBO(191, 0, 10, 1)
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: pageheight * 0.27,
              left: 0.0,
              right: 0.0,
              child: SizedBox(
                width: squareSide,
                height: squareSide,
                child: SvgPicture.asset(
                  "assets/icons/gps.svg",
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.background,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: bottomPosition * 2.7,
                child: SizedBox(
                  width: pagewidth,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextAtom(
                        text: translation(context)!.checking_gps_version,
                        color: Theme.of(context).colorScheme.background,
                        align: TextAlign.center,
                        weight: FontWeight.bold,
                      )
                    ],
                  ),
                )),
            Positioned(
              bottom: bottomPosition * 2.1,
              child: SizedBox(
                width: pagewidth,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Container(
                      height: 10.0,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.3),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: bottomPosition * 2.1,
              child: SizedBox(
                width: pagewidth,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    BlocBuilder<BlocGpsScreen, GpsScreenState>(
                        builder: (context, state) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: 10.0,
                        width: MediaQuery.of(context).size.width *
                            0.8 *
                            state.ratio,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Theme.of(context).colorScheme.background,
                        ),
                      );
                    }),
                  ],
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
                  child: BlocConsumer<BlocGpsScreen, GpsScreenState>(
                      listener: (context, state) async {
                    if (state is GpsScreenSuccessState) {
                      await Future.delayed(
                          const Duration(milliseconds: 300),
                          () => NavigationService().navigateToAndRemoveUntil(
                              context, const HomeScreen(index: 0,)));
                    } else if (state is GpsScreenErrorState) {
                      NavigationService().navigateToAndRemoveUntil(
                          context, const AuthNoInternetScreen());
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
            )
          ],
        ),
      ),
    );
  }
}
