import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../domain/constants/language_constants.dart';
import '../../../../domain/models/user/person.dart';
import '../../../../domain/models/user/user.dart';
import '../../../widgets/atoms/build_text_field.dart';
import '../../../widgets/atoms/error_snackbar.dart';
import '../../../widgets/molecules/my_gradient_btn.dart';
import '../../../widgets/organisms/custom_sliver_appbar.dart';
import '../../auth/components/molecules/profile_image_card.dart';
import '../../auth/components/widgets/vehicle_selector.dart';
import '../../business/widgets/organisms/language_selector.dart';
import '../bloc/bloc_user.dart';

class UserProfileInformation extends StatefulWidget {
  const UserProfileInformation({
    super.key,
  });
  @override
  State<UserProfileInformation> createState() => _UserProfileInformationState();
}

class _UserProfileInformationState extends State<UserProfileInformation> {
  final List<TextEditingController> _controllers =
      List.generate(5, (index) => TextEditingController());
  late Person person;

  @override
  void initState() {
    person = User.getInstance().personData!;
    _controllers[0].text = person.name;
    _controllers[1].text = person.uMobileID;
    _controllers[2].text = person.uPinCode;
    _controllers[3].text = person.uPan;
    _controllers[4].text = person.uIDUPI;
    super.initState();
  }

  Person updateUser() {
    if (esNombreValido(_controllers[0].text) == false) {
      MyErrorSnackBar(
              context: context,
              message:
                  "${translation(context)!.in_the_field_name}\n${translation(context)!.please_enter_only_alphabet_letters}")
          .showSnackBar();
      return throw Exception();
    }
    if (_controllers[0].text.isEmpty || _controllers[3].text.isEmpty) {
      MyErrorSnackBar(
              context: context,
              message: translation(context)!.name_and_pan_are_required)
          .showSnackBar();
      return throw Exception();
    }
    if (validarPINCode(_controllers[2].text) == false) {
      MyErrorSnackBar(
              context: context,
              message: translation(context)!.incorrect_pin_code_format)
          .showSnackBar();
      return throw Exception();
    }
    if (validarPANnumber(_controllers[3].text) == false) {
      MyErrorSnackBar(
              context: context,
              message: translation(context)!.incorrect_pan_number_format)
          .showSnackBar();
      return throw Exception();
    }

    if (validarUPIID(_controllers[4].text) == false) {
      MyErrorSnackBar(
              context: context,
              message: translation(context)!.incorrect_upi_id_format)
          .showSnackBar();
      return throw Exception();
    }

    final Person updatedPerson = Person(
        code: person.code,
        name: _controllers[0].text,
        uMobileID: _controllers[1].text,
        language: person.language == "" ? "en" : person.language,
        uVehicle: person.uVehicle,
        uPan: _controllers[3].text,
        uPinCode: _controllers[2].text,
        uIDUPI: _controllers[4].text);
    return updatedPerson;
  }

  @override
  void dispose() {
    _controllers[0].dispose();
    _controllers[1].dispose();
    _controllers[2].dispose();
    _controllers[3].dispose();
    _controllers[4].dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomSliverAppbar(
              title: translation(context)!.profile_details,
              leading: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const ProfileImageCard(),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Divider(color: Colors.grey.withOpacity(0.5))),
                    BuildTextField(
                      label: translation(context)!.full_name,
                      controller: _controllers[0],
                      hint: person.name,
                    ),
                    BuildTextField(
                      label: translation(context)!.phone,
                      controller: _controllers[1],
                      hint: person.uMobileID,
                      enable: false,
                    ),
                    Row(
                      children: [
                        LanguageSelector(person: person),
                        const SizedBox(width: 16),
                        VehicleSelector(person: person),
                      ],
                    ),
                    const SizedBox(height: 24),
                    BuildTextField(
                      label: translation(context)!.upi_id,
                      controller: _controllers[4],
                      hint: person.uIDUPI,
                    ),
                    BuildTextField(
                      label: translation(context)!.pin_code,
                      controller: _controllers[2],
                      hint: person.uPinCode,
                      type: TextInputType.number,
                      maxLength: 6,
                    ),
                    const SizedBox(height: 16),
                    BuildTextField(
                      label: translation(context)!.pan_number,
                      controller: _controllers[3],
                      hint: person.uPan,
                      maxLength: 10,
                    ),
                    const SizedBox(height: 24),
                    MyGradientBtn(
                      onPressed: () {
                        Person updatedPerson = updateUser();
                        BlocProvider.of<BlocUser>(context)
                            .updatePersonData(updatedPerson);
                        openLoadingDialog(
                            context, BlocProvider.of<BlocUser>(context));
                      },
                      text: translation(context)!.submit,
                      icon: "assets/icons/mano.svg",
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool esNombreValido(String nombre) {
    // Expresión regular que permite letras de a-z (mayúsculas y minúsculas),
    // caracteres del alfabeto hindi, y caracteres comunes en nombres como diéresis y tildes
    final RegExp regex = RegExp(r'^[a-zA-Z\u0900-\u097F\u00C0-\u00FF\s]+$');
    return regex.hasMatch(nombre);
  }

  bool validarPANnumber(String pan) {
    // Expresión regular para validar el número de PAN
    RegExp regExp = RegExp(r"^[A-Z]{5}[0-9]{4}[A-Z]{1}$");

    // Verificar si la entrada coincide con la expresión regular
    if (regExp.hasMatch(pan) && !pan.contains(" ")) {
      return true;
    } else {
      return false;
    }
  }

  bool validarUPIID(String upiID) {
    // Expresión regular para validar UPI
    RegExp regExp = RegExp(r"^[a-zA-Z0-9.-]{2,256}@[a-zA-Z][a-zA-Z]{2,64}$");
    if (regExp.hasMatch(upiID) && !upiID.contains(" ")) {
      return true;
    } else {
      return false;
    }
  }

  bool validarPINCode(String pinCode) {
    // Expresión regular para validar PIN Code
    RegExp regExp = RegExp(r"^[1-9][0-9]{2}\s?[0-9]{3}$");

    // Verificar si la entrada coincide con la expresión regular
    if (regExp.hasMatch(pinCode)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> openLoadingDialog(
      BuildContext context, BlocUser blocUser) async {
    // Muestra el modal de carga
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: BlocProvider.value(
              value: blocUser,
              child:
                  BlocBuilder<BlocUser, UserState>(builder: (context, state) {
                if (state is AuthenticatedSuccessState ||
                    state is AuthenticatedErrorState) {
                  Navigator.pop(context);
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20.0),
                    SpinKitPouringHourGlassRefined(
                      color: Theme.of(context).colorScheme.primary,
                      size: 50.0,
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      "${translation(context)!.running_process}...",
                    ),
                  ],
                );
              })),
        );
      },
    );

  }
}
