import 'package:flutter/material.dart';

abstract class ValidatorHandler {

  ValidatorHandler? _nextHandler;

  Future<void> handleRequest(BuildContext context);

  void handleNext(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 200),(){
      _nextHandler?.handleRequest(context);
    });
  }

  void setNextHandler(ValidatorHandler handler) {
    _nextHandler = handler;
  }
}