import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/constants/language_constants.dart';
import '../../../core/services/business_service.dart';
import '../../../core/services/user_service.dart';
import '../../user/bloc/bloc_user.dart';
import '../bloc/bloc_business.dart';
import '../bloc/my_bloc_bottom_navigation_bar.dart';
import '../widgets/templates/home_template.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.index});
  final int index;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MyBlocBottomNavigationBar(widget.index),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => BlocBusiness(BusinessService(context)),
          lazy: true,
        ),
      ],
      child: const HomeTemplate(),
    );
  }
}
