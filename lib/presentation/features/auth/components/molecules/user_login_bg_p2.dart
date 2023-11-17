import 'package:flutter/material.dart';
import 'dart:math';

class Coin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<Offset> jumpAnimation;

  Coin(TickerProvider vsync) {
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1500),
    );

    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.easeInOutBack);
    jumpAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: Offset(
        Random().nextDouble() * (200) * (Random().nextBool() ? 1 : -1),
        Random().nextDouble() * (500) * (Random().nextBool() ? 1 : -1),
      ),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0, 0.5, curve: Curves.easeOutQuad),
    ));

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        // Elimina la referencia de la moneda al finalizar la animación
        controller.dispose();
      }
    });
  }

  void playAnimation() {
    controller.forward();
  }
}

class UserLoginBgP2 extends StatefulWidget {
  const UserLoginBgP2({Key? key}) : super(key: key);

  @override
  State<UserLoginBgP2> createState() => _UserLoginBgP2State();
}

class _UserLoginBgP2State extends State<UserLoginBgP2> with TickerProviderStateMixin {
  late AnimationController buttonController;
  List<Coin> coins = [];

  @override
  void initState() {
    super.initState();
    buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  void _handleButtonClick() {
    // Agregar animación al presionar el botón
    buttonController.forward(from: 0.0);

    setState(() {
      Coin newCoin = Coin(this);
      coins.add(newCoin);
      newCoin.playAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          for (var coin in coins)
            if (coin.controller.status != AnimationStatus.dismissed)
              AnimatedBuilder(
                animation: coin.controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: coin.jumpAnimation.value,
                    child: Transform.scale(
                      scale: 0.5 + coin.scaleAnimation.value * 0.5,
                      child: Transform.rotate(
                        angle: coin.scaleAnimation.value * pi * 2,
                        child: Image.asset('assets/icons/coin.png', width: 150, height: 150),
                      ),
                    ),
                  );
                },
              ),
          Positioned(
            top: 50,
            child: GestureDetector(
              onTap: _handleButtonClick,
              child: ScaleTransition(
                scale: Tween<double>(begin: 1.0, end: 1.2).animate(buttonController),
                child: Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Image.asset(
                    "assets/icons/ic_launcher_logo.png",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    buttonController.dispose();
    super.dispose();
  }
}
