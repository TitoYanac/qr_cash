import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_save_scan/domain/models/dashboard/qr_response.dart';
import 'package:qr_save_scan/presentation/features/business/bloc/bloc_business.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../../core/services/business_service.dart';
import '../../../../widgets/atoms/text_atom.dart';

class DialogQrCaptureBody extends StatefulWidget {
  const DialogQrCaptureBody({super.key, required this.scannedResult});
  final String scannedResult;

  @override
  State<StatefulWidget> createState() => _DialogQrCaptureBodyState();
}

class _DialogQrCaptureBodyState extends State<DialogQrCaptureBody> {
  bool _isLoading = false;
  String scannedQr = '';

  @override
  void initState() {
    scannedQr = widget.scannedResult;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DialogQrCaptureBody oldWidget) {
    if (scannedQr != widget.scannedResult) {
      setState(() {
        scannedQr = widget.scannedResult;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

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
                    top: MediaQuery.of(context).size.height * 0.06,
                    left: 24,
                    child: TextAtom(
                      text: "${translation(context)!.scanned_qr_code}: ",
                      align: TextAlign.center,
                      weight: FontWeight.bold,
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.095,
                    left: 0,
                    right: 0,
                    child: TextAtom(
                      text: scannedQr,
                      align: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
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

                                  BusinessService businessService = BusinessService(context);
                                  //corregir el formato qr
                                  QrResponse? aux =  await businessService.validateQrCamera(scannedQr);
                                  if (aux != null) {
                                    bool result = await businessService.registerQr(aux!);
                                    BlocProvider.of<BlocBusiness>(context).refreshBusiness();
                                  }
                                  setState(() {
                                    _isLoading = false;
                                  });

                                  debugPrint("_isLoading: $_isLoading");
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
                    "assets/icons/scanned.svg",
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
