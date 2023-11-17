import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../../atoms/big_title_component.dart';
import '../../../../atoms/text_atom.dart';
import '../../../bloc/btn/bloc_btn_state.dart';
import '../../../bloc/btn/bloc_btn.dart';

class MyButtonSubmitGradient extends StatefulWidget {
  const MyButtonSubmitGradient(
      {Key? key,
      required this.onButtonPressed,
      required this.label,
      this.imagenIcon})
      : super(key: key);

  final VoidCallback onButtonPressed;
  final String label;
  final Widget? imagenIcon;
  @override
  State<MyButtonSubmitGradient> createState() => _MyButtonSubmitGradientState();
}

class _MyButtonSubmitGradientState extends State<MyButtonSubmitGradient> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBlocBtn, MyStateBtn>(
        bloc: BlocProvider.of<MyBlocBtn>(context),
        builder: (context, MyStateBtn state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.red, Color.fromRGBO(86, 2, 14, 1)],
                  ),
                  borderRadius: BorderRadius.circular(300.0),
                ),
                constraints: const BoxConstraints(
                  minWidth: 200,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    state.statusButton == 0
                        ? BigTitleComponent(translation(context)!.login).render()
                        : const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                    Opacity(
                      opacity: 0,
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<MyBlocBtn>(context).fetchData();
                          try {
                            widget.onButtonPressed();
                          } catch (e) {
                            BlocProvider.of<MyBlocBtn>(context).cancelFetch();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          translation(context)!.unexpected_error,
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(300.0),
                                ),
                              ),
                            );
                          }
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.resolveWith(
                            (states) => const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 24,
                            ),
                          ),

                          backgroundColor: MaterialStateProperty.all(Colors
                              .transparent), // Set transparent background for the ElevatedButton
                        ),
                        child: Row(
                          children: [
                            TextAtom(
                                text: widget.label,
                                color: Colors.white,
                                weight: FontWeight.bold,
                                size: 30),
                            const SizedBox(
                              width: 12,
                            ),
                            ClipOval(
                              child: Container(
                                height: 40,
                                width: 40,
                                padding: const EdgeInsets.all(8),
                                color: Colors.white,
                                child: widget.imagenIcon ??
                                    const Icon(Icons.fingerprint,
                                        size: 30, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
