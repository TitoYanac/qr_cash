import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../../domain/models/user/bank.dart';
import '../../../../domain/models/user/person.dart';
import '../../../../domain/models/user/user.dart';
import '../../../core/services/user_service.dart';

class BlocUser extends Bloc<UserEvent, UserState> {
  final UserService userService;

  BlocUser(this.userService, initialmessage)
      : super(AuthenticatedPassiveState(initialmessage,
      User.getInstance().personData, User.getInstance().bankData, User.getInstance().imageUrl)) {

    on<UpdatePersonData>((UpdatePersonData event, Emitter<UserState> emit) async {

      final wait = translation(userService.context)!.wait;
      final submit = translation(userService.context)!.submit;
      final error = translation(userService.context)!.error_updating_user_data;
      emit(AuthenticatedLoadingState(wait, event.personData, event.bankData, event.imageUrl));

      final bool result = await userService.updateUserData(event.personData!);

      if (!result) {
        emit(AuthenticatedErrorState(error, event.personData, event.bankData, event.imageUrl));
      }else{
        emit(AuthenticatedSuccessState(submit, event.personData, event.bankData, event.imageUrl));
      }
      await Future.delayed(const Duration(seconds: 2));
      emit(AuthenticatedPassiveState(submit, event.personData, event.bankData, event.imageUrl));
    });

    on<UpdateBankData>((UpdateBankData event, Emitter<UserState> emit) async {
      final wait = translation(userService.context)!.wait;
      final submit = translation(userService.context)!.submit;
      final error = translation(userService.context)!.error_updating_bank_data;
      emit(AuthenticatedPassiveState(wait, event.personData, event.bankData, event.imageUrl));

      final bool result = await userService.updateBankData(event.bankData!);

      if (!result) {
        emit(AuthenticatedErrorState(error, event.personData, event.bankData, event.imageUrl));
      }else{
        emit(AuthenticatedSuccessState(submit, event.personData, event.bankData, event.imageUrl));
      }
      await Future.delayed(const Duration(seconds: 2));
      emit(AuthenticatedPassiveState(submit, event.personData, event.bankData, event.imageUrl));
    });

    on<UpdateImageData>((UpdateImageData event, Emitter<UserState> emit) async {
      final wait = translation(userService.context)!.wait;
      final submit = translation(userService.context)!.submit;
      final error = translation(userService.context)!.error_sending_data;
      emit(AuthenticatedLoadingState(wait, event.personData, event.bankData, event.imageUrl));
      //final bool result = await userService.updateUserImage(event.imageUrl!,event.personData!.uMobileID);

      if (event.imageUrl!.isNotEmpty) {
        emit(AuthenticatedErrorState(error, event.personData, event.bankData, event.imageUrl));
      }else{
        emit(AuthenticatedSuccessState(submit, event.personData, event.bankData, event.imageUrl));
      }
      await Future.delayed(const Duration(seconds: 2));
      emit(AuthenticatedPassiveState(submit, event.personData, event.bankData, event.imageUrl));

    });

  }

  void updatePersonData(Person? personData) {
    Person? newPerson = personData;
    Bank? bankData = User.getInstance().bankData;
    String? imageUrl = User.getInstance().imageUrl;

      add(UpdatePersonData( newPerson, bankData, imageUrl));
  }

  void updateBankData(Bank bankData){
    Person? person = User.getInstance().personData;
    Bank? newBankData = bankData;
    String? imageUrl = User.getInstance().imageUrl;

    add(UpdateBankData( person, newBankData, imageUrl));
  }

  void updateImagePerfil(String imgUrl){
    Person? person = User.getInstance().personData;
    Bank? bankData = User.getInstance().bankData;
    String? imageUrl = imgUrl;

    add(UpdateImageData( person, bankData, imageUrl));
  }
}

class UserEvent {
  final Person? personData;
  final Bank? bankData;
  final String? imageUrl;
  UserEvent(this.personData, this.bankData, this.imageUrl);
}

class UpdatePersonData extends UserEvent {
  UpdatePersonData(super.personData, super.bankData, super.imageUrl);
}

class UpdateBankData extends UserEvent {
  UpdateBankData(super.personData, super.bankData, super.imageUrl);
}

class UpdateImageData extends UserEvent {
  UpdateImageData(super.personData, super.bankData, super.imageUrl);
}

class UserState {
  final String message;
  final Person? personData;
  final Bank? bankData;
  final String? imageUrl;
  UserState(this.message, this.personData, this.bankData, this.imageUrl);
}

class AuthenticatedPassiveState extends UserState {
  AuthenticatedPassiveState(super.message, super.personData, super.bankData, super.imageUrl);
}

class AuthenticatedLoadingState extends UserState {
  AuthenticatedLoadingState(super.message, super.personData, super.bankData, super.imageUrl);
}

class AuthenticatedSuccessState extends UserState {
  AuthenticatedSuccessState(super.message, super.personData, super.bankData, super.imageUrl);
}

class AuthenticatedErrorState extends UserState {
  AuthenticatedErrorState(super.message, super.personData, super.bankData, super.imageUrl);
}
