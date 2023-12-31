import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcash/presentation/atoms/title_component.dart';

import '../features/bloc/btn/bloc_btn_state.dart';
import '../features/bloc/btn/bloc_btn.dart';

class GenericButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onButtonPressed;
  final Widget? imagenIcon;
  const GenericButton(
      {super.key, required this.buttonText,
      required this.onButtonPressed,
      this.imagenIcon});

  @override
  State<GenericButton> createState() => _GenericButtonState();
}

class _GenericButtonState extends State<GenericButton> {
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBlocBtn, MyStateBtn>(
        bloc: BlocProvider.of<MyBlocBtn>(context),
        builder: (context, MyStateBtn state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        BlocProvider.of<MyBlocBtn>(context).fetchData();
                        try {
                          widget.onButtonPressed();
                        } catch (e) {
                          BlocProvider.of<MyBlocBtn>(context).cancelFetch();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Container(
                                color: Colors.transparent,
                                child: const Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "error inesperado",
                                        style: TextStyle(
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
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          );
                        }
                      },
                child: Container(
                  height: 43,
                  width: MediaQuery.of(context).size.width * 0.6,
                  constraints: const BoxConstraints(maxWidth: 350),
                  child: (state.statusButton == 0)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: _isLoading
                              ? [
                                  const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ]
                              : [
                                  TitleComponent(widget.buttonText).render(),
                                  Container(
                                    margin: const EdgeInsets.only(left: 12),
                                    child: widget.imagenIcon,
                                  ),
                                ],
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                ),
              )
            ],
          );
        });
  }
}
