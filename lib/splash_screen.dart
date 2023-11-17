import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/core/validators/handler_server_connection.dart';
import 'presentation/core/validators/handler_user_logged.dart';
import 'presentation/core/validators/validator_handler.dart';
import 'presentation/features/bloc/status/bloc_status_text.dart';
import 'presentation/features/bloc/status/bloc_status_text_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    ValidatorHandler validatorUserLogged = HandlerUserLogged();
    ValidatorHandler validatorServer = HandlerServerConnection();
    validatorUserLogged.setNextHandler(validatorServer);
    validatorUserLogged.handleRequest(context);
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return Scaffold(
      body: Container(
        color: Colors.transparent,
        child: BlocBuilder<BlocStatusText, StatusTextState>(
          bloc: BlocProvider.of<BlocStatusText>(context),
          builder: (context, StatusTextState state) {
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                ),
                Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset("assets/icons/ic_launcher_logo.png"),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height-200,
                  child: BlocBuilder<BlocStatusText, StatusTextState>(
                    bloc: BlocProvider.of<BlocStatusText>(context),
                    builder: (context, StatusTextState state) {
                      return Container(color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  state.statusText,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
