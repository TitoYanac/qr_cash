import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../../../domain/models/business/business.dart';
import '../../../../core/services/authentication_service.dart';
import '../../../../core/services/business_service.dart';
import '../../../../widgets/atoms/text_atom.dart';
import '../../bloc/bloc_business.dart';

class DialogCloudBody extends StatefulWidget {
  const DialogCloudBody({super.key});
  @override
  State<StatefulWidget> createState() => _DialogCloudBodyState();
}

class _DialogCloudBodyState extends State<DialogCloudBody> {
  bool _isLoading = false;
  String scannedQr = '';


  @override
  Widget build(BuildContext context) {
    Widget btnClosePaymentPopUp = Positioned(
      top: 50.0,
      right: 0,
      child: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          if(!_isLoading){
            Navigator.of(context).pop();
          }
        },
      ),
    );
    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(0.0),
              height: (MediaQuery.of(context).size.height * 0.3) - 50,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2.0,
                  )),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.085,
                    left: 0,
                    right: 0,
                    child: TextAtom(
                      text: translation(context)!.do_you_want_to_submit_your_pending_qr_codes,
                      align: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(18.0),
                          bottomRight: Radius.circular(18.0),
                        ),
                        border: Border(
                          top: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2.0),
                          bottom: BorderSide.none,
                          left: BorderSide.none,
                          right: BorderSide.none,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if(!_isLoading){
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height:
                                MediaQuery.of(context).size.height * 0.06,
                                child: TextAtom(
                                  text: translation(context)!.close,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary,
                                  align: TextAlign.center,
                                  weight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: 2,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                if (_isLoading == false) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  await BusinessService(context)
                                            .registerListQRrejected(
                                                Business.getInstance()
                                                    .qrRejectedManager!
                                                    .data)
                                            .then((value) {
                                          return value;
                                        });
                                        BlocProvider.of<BlocBusiness>(context)
                                            .refreshBusiness();

                                  await AuthenticationService(context).fetchBusinessDataInitial().then(
                                          (value) => BlocProvider.of<BlocBusiness>(context)
                                          .refreshBusiness());
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height:
                                MediaQuery.of(context).size.height * 0.06,
                                child: (_isLoading)
                                    ? SpinKitPouringHourGlassRefined(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary,
                                )
                                    : TextAtom(
                                  text: translation(context)!.accept,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary,
                                  align: TextAlign.center,
                                  weight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.height * 0.1,
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/nube.svg",
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.center,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.background,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
          btnClosePaymentPopUp,
        ],
      ),
    );
  }
}
