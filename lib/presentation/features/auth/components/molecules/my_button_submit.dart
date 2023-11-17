import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../atoms/big_title_component.dart';
import '../../../bloc/btn/bloc_btn_state.dart';
import '../../../bloc/btn/bloc_btn.dart';

class MyButtonSubmit extends StatefulWidget {
  const MyButtonSubmit(
      {Key? key,
      required this.onButtonPressed,
      required this.label,
      this.imagenIcon})
      : super(key: key);

  final VoidCallback onButtonPressed;
  final String label;
  final Widget? imagenIcon;
  @override
  State<MyButtonSubmit> createState() => _MyButtonSubmitState();
}

class _MyButtonSubmitState extends State<MyButtonSubmit> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBlocBtn, MyStateBtn>(
        bloc: BlocProvider.of<MyBlocBtn>(context),
        builder: (context, MyStateBtn state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.transparent,
                constraints: const BoxConstraints(
                  minWidth: 200,
                ),
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
                  style: ButtonStyle(
                    padding: MaterialStateProperty.resolveWith((states) =>
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 24)),
                  ),
                  child: state.statusButton == 0
                      ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BigTitleComponent(widget.label).render(),
                            const SizedBox(
                              width: 12,
                            ),
                            ClipOval(
                              child: Container(
                                height: 40,
                                width: 40,
                                padding: const EdgeInsets.all(8),
                                color: Colors.white,
                                child: SizedBox.expand(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Center(
                                      child: widget.imagenIcon ??
                                          Image.asset(
                                              "assets/icons/next_icon.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          );
        });
  }
}
