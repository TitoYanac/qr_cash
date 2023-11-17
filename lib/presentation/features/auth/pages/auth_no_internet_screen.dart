import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../../splash_screen.dart';

class AuthNoInternetScreen extends StatelessWidget {
  const AuthNoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: SvgPicture.asset(
                  "assets/icons/no_wifi.svg",
                  fit: BoxFit.contain,
                )), // Agrega la imagen que desees
            const SizedBox(height: 20),
            Text(
              translation(context)!.you_are_not_connected_to_the_internet,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              translation(context)!.check_your_connection_and_try_again,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                // Cerrar la aplicación
                await Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                );
              },
              child: Text(
                translation(context)!.reconnect,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
