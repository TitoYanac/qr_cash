import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_save_scan/presentation/widgets/molecules/my_gradient_btn.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../core/services/navigation_service.dart';
import '../../../widgets/organisms/custom_sliver_appbar.dart';
import 'splash_screen.dart';
import '../../../bloc/status/bloc_splash_screen.dart';
import '../../../core/services/authentication_service.dart';

class AuthNoInternetScreen extends StatelessWidget {
  const AuthNoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppbar(
            title: translation(context)!.red_network_error,
            leading: false,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.width * 0.3,
                    color: Colors.transparent,
                    child: SvgPicture.asset(
                      "assets/icons/no_wifi.svg",
                      fit: BoxFit.contain,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.shadow.withOpacity(0.7),
                        BlendMode.srcIn,
                      ),
                    ),), // Agrega la imagen que desees
                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                Text(
                  translation(context)!.you_are_not_connected_to_the_internet,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                Text(
                  translation(context)!.check_your_connection_and_try_again,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.12,),
                MyGradientBtn(
                  onPressed: () async {
                    // Cerrar la aplicación
                    NavigationService().navigateToAndRemoveUntil(
                      context,
                      BlocProvider<BlocSplashScreen>(
                        create: (BuildContext contexto) =>
                            BlocSplashScreen(AuthenticationService(contexto)),
                        child: const SplashScreen(),
                      ),
                    );
                  },
                  text: translation(context)!.reconnect,
                ),
              ],
            ),
          )
        ]
      ),
    );
  }
}
