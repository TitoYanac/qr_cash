import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../domain/constants/language_constants.dart';
import '../../../domain/models/user/user.dart';
import '../../../main.dart';
import '../../features/bloc/status/bloc_status_text.dart';
import '../../features/business/pages/home_page.dart';
import '../services/business_service.dart';
import '../services/navigation_service.dart';
import 'validator_handler.dart';

class HandlerGPSConnection extends ValidatorHandler {
  @override
  Future<void> handleRequest(BuildContext context) async {
    final blocStatusText = BlocProvider.of<BlocStatusText>(context);

    User.getInstance().buildNetworkImage(context);
    Future.delayed(const Duration(milliseconds: 500));
    // Verificar si los servicios de geolocalización están habilitados
    await checkGPSConnectivity().then((value) {
      Future.delayed(const Duration(milliseconds: 500));
      if (!value) {
        blocStatusText.changeStatus(translation(context)!.gps_disabled);
        return; // Salir si los servicios de geolocalización están deshabilitados
      }
    });

    // Solicitar permiso de ubicación
    await _requestLocationPermission().then((value) {
      if (value == LocationPermission.always ||
          value == LocationPermission.whileInUse) {
        blocStatusText.changeStatus(translation(context)!.gps_enabled);
      } else {
        blocStatusText.changeStatus(
            translation(context)!.verification_failed_or_gps_disabled);
      }
    });

    //cargar los datos de usuario online
    await Future.delayed(const Duration(milliseconds: 500)).then((value) {
      User user = User.getInstance();
      // cagamos datos de la aplicacion en paralelo
      Future.wait([
        loadLanguage(context, user.personData!.language),
        BusinessService(context).fetchContacts(),
        BusinessService(context).fetchBanks(),
        BusinessService(context).fetchVideos(),
        BusinessService(context).fetchDashboardTotal(), // dashboard banner
        BusinessService(context).fetchDashboardToday(), // dashboard body
        BusinessService(context).LoadListTotalQR(), // lista total Accepted qr
        //cargar lista scaneada de qr de shared preferences
      ]).then((value) {
        Future.wait([
          BusinessService(context).LoadAcceptedTotalQR(), // lista total Accepted qr
          BusinessService(context).LoadPendingTotalQR(), // lista total Pending qr
          BusinessService(context).LoadRejectedTotalQR(), // lista total Rejected qr
        ]).then((value) => NavigationService()
            .navigateToAndRemoveUntil(context, const HomePage()));
      });
    });

    //NavigationService().navigateTo(context, HomePage());
  }

  Future<LocationPermission> _requestLocationPermission() async {
    final status = await Geolocator.requestPermission();
    return status;
  }

  Future<bool> checkGPSConnectivity() async {
    final gps = await Geolocator.isLocationServiceEnabled();
    return gps;
  }

  Future<void> loadLanguage(context, language) async {
    language = language == '' ? 'en' : language;
    MyApp.setLocale(context, Locale(language));
  }
}
