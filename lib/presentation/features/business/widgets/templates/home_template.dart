import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../widgets/bottom_navbar_navigation.dart';
import '../../bloc/bloc_bottom_navigation_bar_state.dart';
import '../../bloc/bloc_business.dart';
import '../../bloc/my_bloc_bottom_navigation_bar.dart';
import '../../pages/page1_dashboard_screen.dart';
import '../../pages/page2_report_screen.dart';
import '../../pages/page3_qr_scan_screen.dart';
import '../../pages/page4_multimedia_screen.dart';
import '../../pages/page5_account_screen.dart';
import '../organisms/dialog_cloud_body.dart';
import '../organisms/dialog_payment_body.dart';

class HomeTemplate extends StatefulWidget {
  const HomeTemplate({super.key});

  @override
  State<HomeTemplate> createState() => _HomeTemplateState();
}

class _HomeTemplateState extends State<HomeTemplate> {
  int indexTabPage = 0;
  late List<dynamic> data;
  final TextEditingController _amountController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  bool isProcessing = false; // Estado de procesamiento del botón
  bool isProcessingCloud = false;

  bool isLoading = false;
  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }


  void showPopupCloud(BuildContext contexto, BlocBusiness blocBusiness)  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          insetPadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(0),

          content: BlocProvider.value(
              value: blocBusiness,
              child: const DialogCloudBody()),
        );
      },
    );
  }

  void showPopupPayment(BuildContext context, BlocBusiness blocBusiness) {
    _amountController.text = "";
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
          insetPadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(0),
          content: BlocProvider.value(
              value: blocBusiness,
              child: DialogPaymentBody(amountController: _amountController)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget floatingPaymentButton = FloatingActionButton(
      onPressed: () =>
          showPopupPayment(context, BlocProvider.of<BlocBusiness>(context)),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.background,

      child: Container(
        padding: const EdgeInsets.all(8),
        child: SvgPicture.asset(
          "assets/icons/wallet.svg",
          fit: BoxFit.contain,
          colorFilter:
          ColorFilter.mode(Theme.of(context).colorScheme.background,
              BlendMode.srcIn),
        ),
      ),
    );
    Widget floatingCloudButton = FloatingActionButton(
      onPressed: () =>
          showPopupCloud(context, BlocProvider.of<BlocBusiness>(context)),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.background,

      child: Container(
        padding: const EdgeInsets.all(8),
        child: SvgPicture.asset(
          "assets/icons/nube.svg",
          fit: BoxFit.contain,
          colorFilter:
              ColorFilter.mode(Theme.of(context).colorScheme.background,
                  BlendMode.srcIn),
        ),
      ),
    );


    var botones = [
      [Container(), Container(), Container()],
      //[floatingPaymentButton, floatingPaymentButton, floatingCloudButton],
      //[Container(), Container(), Container()],
      [floatingPaymentButton, floatingPaymentButton, floatingCloudButton],
      [Container(), Container(), Container()],
      [Container(), Container(), Container()],
      [Container(), Container(), Container()],
    ];

    return BlocBuilder<MyBlocBottomNavigationBar, MyBottomNavigationBarState>(
      builder: (context, MyBottomNavigationBarState stateIndex) {
        if (stateIndex.page != 1) {
          indexTabPage = 0;
        }
        return SafeArea(
          top: true,
          bottom: true,
          child: Scaffold(
            body: (stateIndex.page == 0)
                ? const DashboardScreen()
                : (stateIndex.page == 1)
                    ? ReportScreen(
                        handleIndexTabBar: (int newindex) => setState(() {
                              indexTabPage = newindex;
                            }))
                    : (stateIndex.page == 2)
                        ? const QrScanScreen()
                        : (stateIndex.page == 3)
                            ? const MultimediaScreen()
                            : (stateIndex.page == 4)
                                ? const AccountScreen()
                                : Container(),
            bottomNavigationBar: const BottomNavBar(),
            floatingActionButton: botones[stateIndex.page][indexTabPage],
          ),
        );
      },
    );
  }

}


