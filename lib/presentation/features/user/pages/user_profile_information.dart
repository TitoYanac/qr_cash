import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcash/presentation/core/services/navigation_service.dart';
import 'package:qrcash/presentation/features/user/bloc/bloc_user.dart';
import 'package:qrcash/presentation/features/user/bloc/bloc_user_state.dart';
import 'package:qrcash/presentation/features/widgets/appbar_with_leading.dart';
import '../../../../domain/constants/language_constants.dart';
import '../../../../domain/models/user/person.dart';
import '../../../../domain/models/user/user.dart';
import '../../../atoms/build_text_field.dart';
import '../../../atoms/error_snackbar.dart';
import '../../../core/services/user_service.dart';
import '../../auth/components/molecules/my_button_submit.dart';
import '../../auth/components/molecules/profile_image_card.dart';
import '../../auth/components/widgets/vehicle_selector.dart';
import '../../business/components/widgets/language_selector.dart';
import '../../business/pages/home_page.dart';

class UserProfileInformation extends StatefulWidget {
  const UserProfileInformation({
    Key? key,
  }) : super(key: key);

  @override
  State<UserProfileInformation> createState() => _UserProfileInformationState();
}

class _UserProfileInformationState extends State<UserProfileInformation> {
  final List<TextEditingController> _controllers = List.generate(100, (index) => TextEditingController());

  late String imageBase64 = '';
  Person person = Person();

  @override
  void initState() {
    loadPerson();
    super.initState();
  }

  Future<void> loadPerson() async {
    User user = User.getInstance();
    Person personData = user.personData!;
    setState(() {
      person = personData;
      _controllers[0].text = person.name;
      _controllers[1].text = person.uMobileID;
      _controllers[2].text = person.uPinCode;
      _controllers[3].text = person.uPan;
      _controllers[4].text = person.uIDUPI;
    });
  }

  Future<void> updateUser() async {
    if (_controllers[0].text.isEmpty) {
      MyErrorSnackBar(
              context: context,
              message: translation(context)!.name_and_pan_are_required)
          .showSnackBar();
      return;
    }

    final Person updatedPerson = Person(
      code: person.code,
      name: person.name,
      uMobileID: person.uMobileID,
      language: person.language==""?"en":person.language,
      uVehicle: person.uVehicle,
      uPan: person.uPan,
      uPinCode: person.uPinCode,
      uIDUPI: person.uIDUPI
    );
print(updatedPerson);
    await UserService(context).updateUserData(updatedPerson);
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
      bottom: true,
      child: WillPopScope(
        onWillPop: () async {
          NavigationService()
              .navigateToAndRemoveUntil(context, const HomePage());
          return false;
        },
        child: Scaffold(
          appBar:
              MyAppBarWithLeading(title: translation(context)!.account_options)
                  .getAppBar(),
          body: BlocProvider(
            create: (BuildContext context)=> BlocUser(BlocUserState(User.getInstance())),
            child: buildBody()  ,
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const ProfileImageCard(),
        Padding(padding:const EdgeInsets.symmetric(vertical: 16),child: Divider(color: Colors.grey.withOpacity(0.5))),
        BuildTextField(
          label: translation(context)!.full_name,
          controller: _controllers[0],
          hint: person.name,
        ),
        BuildTextField(
          label: translation(context)!.phone,
          controller: _controllers[1],
          hint: person.uMobileID ?? 'Ingrese número de celular',
          enable: false,
        ),
        LanguageSelector(person: person),
        const SizedBox(height: 16),
        BuildTextField(
          label: translation(context)!.pin_code,
          controller: _controllers[2],
          hint: person.uPinCode ?? "Ingrese PIN",
        ),
        VehicleSelector(person: person),
        const SizedBox(height: 16),
        BuildTextField(
          label: translation(context)!.pan_number,
          controller: _controllers[3],
          hint: person.uPan ?? "Ingrese PAN",
        ),
        BuildTextField(
          label: translation(context)!.upi_id,
          controller: _controllers[4],
          hint: person.uIDUPI ?? "Ingrese ID UPI",
        ),
        const SizedBox(height: 24),
        MyButtonSubmit(
          onButtonPressed: () async {
            //await Future.delayed(const Duration(seconds: 1));

            updateUser();
          },
          label: translation(context)!.save_changes,
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
