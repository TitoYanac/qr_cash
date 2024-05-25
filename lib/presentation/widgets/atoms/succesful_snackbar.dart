import 'package:flutter/material.dart';
class MySuccesfulSnackBar{
  final BuildContext context;
  final String message;
  final String? label;
  final Widget? page;

  MySuccesfulSnackBar({required this.context,required this.message, this.label,this.page});

  showSnackBar(){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 14.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.green,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
