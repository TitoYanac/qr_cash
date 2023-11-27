import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
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
                  child: Center(
                    child: (state.statusButton == 0)
                        ? GestureDetector(
                            onTap: () {
                              BlocProvider.of<MyBlocBtn>(context).fetchData();
                              try {
                                widget.onButtonPressed();
                              } catch (e) {
                                BlocProvider.of<MyBlocBtn>(context)
                                    .cancelFetch();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Container(
                                      color: Colors.transparent,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              translation(context)!
                                                  .unexpected_error,
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
                                      borderRadius:
                                          BorderRadius.circular(300.0),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              translation(context)!.login,
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : SizedBox(height:24,width: 24,child: const CircularProgressIndicator(color: Colors.white,)),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
