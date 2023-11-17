import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcash/domain/models/user/user.dart';
import 'package:qrcash/presentation/atoms/title_component.dart';
import 'package:qrcash/presentation/features/auth/components/molecules/my_button_submit.dart';
import '../../../../../domain/constants/language_constants.dart';
import '../../../../core/services/business_service.dart';
import '../../../bloc/btn/bloc_btn.dart';
import '../../bloc/bloc_bottom_navigation_bar_state.dart';
import '../../bloc/bloc_business.dart';
import '../../bloc/bloc_business_state.dart';
import '../../bloc/my_bloc_bottom_navigation_bar.dart';
import 'account_template.dart';
import 'dashboard_template.dart';
import 'qr_template.dart';
import 'report_template.dart';
import 'videos_template.dart';

class HomeTemplate extends StatefulWidget {
  const HomeTemplate({Key? key}) : super(key: key);

  @override
  State<HomeTemplate> createState() => _HomeTemplateState();
}

class _HomeTemplateState extends State<HomeTemplate> {
  int indexTabPage = 0;
  final bool _isLoading = false;
  late List<dynamic> data;
  // Declara la lista de pantallas internas
  late List<Widget> _contenido;
  final TextEditingController _amountController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  final bool _isLoadingQuery = false; // Variable para controlar la consulta

  bool isProcessing = false; // Estado de procesamiento del botón
  bool isProcessingCloud = false;

  @override
  Widget build(BuildContext context) {
    void _showPopupPayment(String amount) {
      Widget imageBannerPopUp = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: Image.asset(
              "assets/images/witdrawmoney.png",
            ),
          )
        ],
      );
      Widget titlePaymentPopUp = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${translation(context)!.available_balance}:\n$amount',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18.0,
            ),
          ),
        ],
      );
      Widget inputPaymentPopUp = TextField(
        controller:
            _amountController, // Controlador para manejar el valor del campo
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: translation(context)!.withdrawal_amount,
          hintText: translation(context)!.enter_the_amount,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleComponent("₹").render(),
              ],
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
      Widget btnSubmitPaymentPopUp = MyButtonSubmit(
          onButtonPressed: () async {
            if (_isLoading == false) {
              await BusinessService(context)
                  .requestTransfer(_amountController.text)
                  .then((value) {
                print(value);
                setState(() {
                  isProcessing = false;

                  Navigator.of(context).pop();
                });
              });
            }
          },
          label: translation(context)!.accept);
      Widget btnClosePaymentPopUp = Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          bool isProcessing = false; // Nuevo estado para controlar la carga

          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                backgroundColor: Colors.white,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Stack(
                      fit: StackFit.loose,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(40.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20.0),
                              imageBannerPopUp,
                              const SizedBox(height: 20.0),
                              titlePaymentPopUp,
                              const SizedBox(height: 30.0),
                              inputPaymentPopUp,
                              const SizedBox(height: 30.0),
                              btnSubmitPaymentPopUp,
                              const SizedBox(height: 20.0),
                            ],
                          ),
                        ),
                        btnClosePaymentPopUp,
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    void _showPopupCloud(context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return BlocBuilder<BlocBusiness, BlocBusinessState>(
                  bloc: BlocProvider.of<BlocBusiness>(context),
                  builder: (contextBusiness, BlocBusinessState stateBusiness) {
                    print(stateBusiness.business.qrPendingManager!.toJson());
                    print(translation(contextBusiness)?.error_sending_data);
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(40.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 20.0),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${translation(contextBusiness)!.validate_pending_codes}?',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 18.0),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 60.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(contextBusiness).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: Text(
                                    translation(contextBusiness)!.close,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: isProcessingCloud
                                      ? null
                                      : () async {
                                          setState(() {
                                            isProcessingCloud = true;

                                            BlocProvider.of<MyBlocBtn>(context)
                                                .fetchData();
                                          });

                                          // Simulación de espera para la API
                                          Future.delayed(Duration.zero,
                                            () {
                                              BusinessService(contextBusiness)
                                                  .registerListQRrejected(
                                                      stateBusiness
                                                          .business
                                                          .qrPendingManager!
                                                          .Data)
                                                  .then((value) {
                                                setState(() {
                                                  isProcessingCloud = false;
                                                });

                                                BlocProvider.of<MyBlocBtn>(
                                                        context)
                                                    .cancelFetch();
                                                Navigator.of(contextBusiness)
                                                    .pop();
                                              });
                                            },
                                          );
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: isProcessingCloud
                                      ? const CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        )
                                      : Text(
                                          translation(contextBusiness)!.accept,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
          );
        },
      );
    }

    PreferredSizeWidget? myAppBar = AppBar(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.38,
            child: Image.asset("assets/icons/listoil_red_appbar.png"),
          ),
        ],
      ),
    );
    Widget floatingPaymentButton =
        BlocBuilder<BlocBusiness, BlocBusinessState>(
            bloc: BlocProvider.of<BlocBusiness>(context),
            builder: (context, BlocBusinessState stateBusiness) {
              return FloatingActionButton(
                onPressed: () {
                  String availableAmount =
                      stateBusiness.business.dashboardTotal!.entry[0].Amount;

                  _showPopupPayment(availableAmount);
                },
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.payment,
                  size: 34,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              );
            });
    Widget floatingCloudButton = BlocBuilder<BlocBusiness, BlocBusinessState>(
        bloc: BlocProvider.of<BlocBusiness>(context),
        builder: (context, BlocBusinessState stateBusiness) {
          return FloatingActionButton(
            onPressed: () => _showPopupCloud(context),
            backgroundColor: Colors.white,
            child: Icon(
              Icons.cloud_upload,
              size: 34,
              color: Theme.of(context).colorScheme.secondary,
            ),
          );
        });
    Widget floatingTestButton = BlocBuilder<BlocBusiness, BlocBusinessState>(
        bloc: BlocProvider.of<BlocBusiness>(context),
        builder: (context, BlocBusinessState stateBusiness) {
          return FloatingActionButton(
            onPressed: () async {

              print(User.getInstance().imageUrl);
              /*
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              print(stateBusiness.business.dashboardToday!.toJson());
              print(preferences.getString(
                  "qrResumenTotalDia${User.getInstance().personData!.uMobileID}"));

              print(
                  "----------------------preferences qrPendingTotal------------------------------------------");
              print(preferences.getString(
                  "qrPendingTotal${User.getInstance().personData!.uMobileID}"));
              print(stateBusiness.business.qrPendingManager!.toJson());*/
            },
            backgroundColor: Colors.white,
            child: Icon(
              Icons.telegram_sharp,
              size: 34,
              color: Theme.of(context).colorScheme.secondary,
            ),
          );
        });
    var botones = [
      //[_floatingTestButton, _floatingTestButton, _floatingTestButton],
      [Container(), Container(), Container()],
      [floatingPaymentButton, floatingPaymentButton, floatingCloudButton],
      [Container(), Container(), Container()],
      [Container(), Container(), Container()],
      [Container(), Container(), Container()],
    ];

    return BlocBuilder<BlocBusiness, BlocBusinessState>(
      bloc: BlocProvider.of<BlocBusiness>(context),
      builder: (context, BlocBusinessState stateBusiness) {
        return BlocBuilder<MyBlocBottomNavigationBar,
            MyBottomNavigationBarState>(
          bloc: BlocProvider.of<MyBlocBottomNavigationBar>(context),
          builder: (context, MyBottomNavigationBarState stateIndex) {
            if (stateIndex.page != 1) {
              indexTabPage = 0;
            }
            _contenido = [
              const DashboardTemplate(),
              ReportTemplate(
                handleIndexTabBar: (int newindex) => setState(() {
                  indexTabPage = newindex;
                }),
                business: stateBusiness.business,
              ),
              const QrTemplate(),
              const VideosTemplate(),
              const AccountTemplate(),
            ];
            return SafeArea(
              top: false,
              bottom: true,
              child: Scaffold(
                appBar: myAppBar,
                body: _contenido[stateIndex.page],
                bottomNavigationBar: const BottomNavBar(),
                floatingActionButton: botones[stateIndex.page][indexTabPage],
              ),
            );
          },
        );
      },
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBlocBottomNavigationBar, MyBottomNavigationBarState>(
        bloc: BlocProvider.of<MyBlocBottomNavigationBar>(context),
        builder: (context, MyBottomNavigationBarState state) {
          return CurvedNavigationBar(
            //key: _bottomNavigationKey,
            index: state.page,
            height: 60.0,

            items: <Widget>[
              Icon(
                Icons.home,
                size: 30,
                color: state.page != 0 ? Colors.black : Colors.white,
              ),
              Icon(
                Icons.list,
                size: 30,
                color: state.page != 1 ? Colors.black : Colors.white,
              ),
              Icon(
                Icons.qr_code_scanner,
                size: 30,
                color: state.page != 2 ? Colors.black : Colors.white,
              ),
              Icon(
                Icons.video_library,
                size: 30,
                color: state.page != 3 ? Colors.black : Colors.white,
              ),
              Icon(
                Icons.perm_identity,
                size: 30,
                color: state.page != 4 ? Colors.black : Colors.white,
              ),
            ],
            color: const Color.fromRGBO(234, 238, 250, 1),
            buttonBackgroundColor: Theme.of(context).colorScheme.secondary,
            backgroundColor: state.page == 2 ? Colors.black : Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              BlocProvider.of<MyBlocBottomNavigationBar>(context).toPage(index);
            },
            letIndexChange: (index) => true,
          );
        });
  }
}
