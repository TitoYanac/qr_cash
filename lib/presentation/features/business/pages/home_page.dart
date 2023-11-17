import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcash/domain/models/business/business.dart';
import 'package:qrcash/domain/models/user/user.dart';
import 'package:qrcash/presentation/features/business/bloc/bloc_business.dart';
import 'package:qrcash/presentation/features/business/bloc/bloc_business_state.dart';
import '../../user/bloc/bloc_user.dart';
import '../../user/bloc/bloc_user_state.dart';
import '../components/templates/home_template.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocBusiness>(
            create: (BuildContext context) =>
                BlocBusiness(BlocBusinessState(Business.getInstance()))),
        BlocProvider<BlocUser>(
            create: (BuildContext context) =>
                BlocUser(BlocUserState(User.getInstance()))),
      ],
      child: const HomeTemplate(),
    );
  }
}
