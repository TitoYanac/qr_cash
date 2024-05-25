import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/constants/language_constants.dart';
import '../../../domain/models/user/user.dart';
import '../../core/services/authentication_service.dart';


class BlocGpsScreen extends Bloc<GpsScreenEvent, GpsScreenState> {
  final AuthenticationService authenticationService;

  BlocGpsScreen(this.authenticationService)
      : super(GpsScreenInitialState(" ", 0.0)) {
    on<CheckGpsScreenValidations>(_checkGpsScreenValidations);
  }

  void triggerValidations() => add(CheckGpsScreenValidations());

  Future<void> _checkGpsScreenValidations(CheckGpsScreenValidations event,
      Emitter<GpsScreenState> emit) async {
    String unknownError = "Error inesperado";
    try {
      await _validateGps(emit);
      await _fetchUser(emit);
      await _loadLanguage(emit);
      await _fetchBusiness(emit);
    } catch (e) {
      emit(GpsScreenErrorState("$unknownError: $e", 1.0));
    }
  }
  Future<void> _validateGps(Emitter<GpsScreenState> emit) async {
    final traductor = translation(authenticationService.context)!;
    String verifyingGps = traductor.verifying_gps;
    String gpsAvailable = traductor.gps_enabled;
    String gpsNotAvailable = traductor.gps_disabled;
    emit(GpsScreenLoadingState(verifyingGps, 0.125));
    await Future.delayed(const Duration(milliseconds: 200));
    await authenticationService.checkGPSConnectivity()
        ? emit(GpsScreenLoadingState(gpsAvailable, 0.25))
        : emit(GpsScreenLoadingState(gpsNotAvailable, 0.25));
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<void> _fetchUser(Emitter<GpsScreenState> emit) async {
    final traductor = translation(authenticationService.context)!;
    String loadingUser = traductor.loading_user_data;
    String userData = traductor.user_data_loaded;
    String errorLoading = traductor.error_loading_user_offline;

    emit(GpsScreenLoadingState(loadingUser, 0.30));
    await Future.delayed(const Duration(milliseconds: 200));
    bool userDataLoaded = await authenticationService.loadUserInitialData();
    if (userDataLoaded) {
      emit(GpsScreenLoadingState(userData, 0.5));
    }else{
      emit(GpsScreenErrorState(errorLoading, 0.5));
    }
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<void> _loadLanguage(Emitter<GpsScreenState> emit) async {
    final traductor = translation(authenticationService.context)!;
    String language = traductor.language;
    String successfulValidation = traductor.successful_validation;
    String somethingWentWrong = traductor.something_went_wrong;

    emit(GpsScreenLoadingState(language, 0.6));
    await Future.delayed(const Duration(milliseconds: 200));
    bool userDataLoaded = await authenticationService.loadLanguage();
    if (userDataLoaded) {
      emit(GpsScreenLoadingState(successfulValidation,0.7));
    }else{
      emit(GpsScreenErrorState(somethingWentWrong,0.7));
    }
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<void> _fetchBusiness(Emitter<GpsScreenState> emit) async {
    final traductor = translation(authenticationService.context)!;
    String bankInformation = traductor.bank_information;
    String banksLoaded = traductor.banks_loaded;
    String dataNotFound = traductor.data_not_found;
    emit(GpsScreenLoadingState(bankInformation,0.85));
    await Future.delayed(const Duration(milliseconds: 200));
    bool dataLoaded = await authenticationService.fetchBusinessDataInitial();
    if (dataLoaded) {
      if(User.getInstance().imageUrl != ""){

        emit(GpsScreenLoadingState(traductor.profile_details,0.95));
        User.getInstance().buildNetworkImage(authenticationService.context);
      }

      await Future.delayed(const Duration(milliseconds: 200));
      emit(GpsScreenSuccessState(banksLoaded,1.0));
    }else{
      emit(GpsScreenErrorState(dataNotFound,1.0));
    }
  }

}

class GpsScreenEvent {}

class CheckGpsScreenValidations extends GpsScreenEvent {}

class GpsScreenState {
  String message;
  double ratio;
  GpsScreenState(this.message, this.ratio);
}

class GpsScreenInitialState extends GpsScreenState {
  GpsScreenInitialState(super.message, super.ratio);
}

class GpsScreenLoadingState extends GpsScreenState {
  GpsScreenLoadingState(super.message, super.ratio);
}

class GpsScreenErrorState extends GpsScreenState {
  GpsScreenErrorState(super.message, super.ratio);
}

class GpsScreenSuccessState extends GpsScreenState {
  GpsScreenSuccessState(super.message, super.ratio);
}