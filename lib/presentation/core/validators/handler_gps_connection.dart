import 'dart:async';

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
    final translator = translation(context)!;

    // Funciones locales para redirección y carga de datos en segundo plano
    void redirect() => NavigationService().navigateToAndRemoveUntil(context, const HomePage());
    void loadUserData() => _loadUserDataInBackground(context);

    // Verificar si los servicios de geolocalización están habilitados
    User user = User.getInstance();

    // Cargar idioma en segundo plano
    loadLanguage(context, user.personData!.language);

    // Cargar imagen de usuario en segundo plano
    user.buildNetworkImage(context);

    bool gpsEnabled = await checkGPSConnectivity();
    if (gpsEnabled) {
      blocStatusText.changeStatus(translator.gps_enabled);
    } else {
      // Solicitar permiso de ubicación
      LocationPermission locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.always || locationPermission == LocationPermission.whileInUse) {
        blocStatusText.changeStatus(translator.gps_enabled);
      } else {
        blocStatusText.changeStatus(translator.verification_failed_or_gps_disabled);
      }

      // Cargar los datos de usuario online en segundo plano
    }
    loadUserData();

    // Navegar a la página principal y eliminar la pila de navegación
    redirect();
  }

  Future<void> _loadUserDataInBackground(BuildContext context) async {
    BusinessService businessService = BusinessService(context);

    // Cargar datos de la aplicación en paralelo
    await Future.wait([
      businessService.fetchContacts(),
      businessService.fetchBanks(),
      businessService.fetchVideos(),
      businessService.fetchDashboardTotal(),
      businessService.fetchDashboardToday(),
      businessService.LoadListTotalQR(),
    ]);

    // Cargar listas adicionales en paralelo
    await Future.wait([
      businessService.LoadAcceptedTotalQR(),
      businessService.LoadPendingTotalQR(),
      businessService.LoadRejectedTotalQR(),
    ]);
  }

  Future<bool> checkGPSConnectivity() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<void> loadLanguage(BuildContext context, String language) async {
    language = language == '' ? 'en' : language;
    MyApp.setLocale(context, Locale(language));
  }
}
