import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_save_scan/presentation/core/services/navigation_service.dart';
import 'package:qr_save_scan/presentation/features/user/pages/qr_entry_manual_page.dart';
import 'package:qr_save_scan/presentation/widgets/atoms/text_atom.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../../core/services/business_service.dart';
import '../../../../widgets/molecules/my_gradient_btn.dart';
import '../../../../widgets/organisms/custom_sliver_appbar.dart';
import '../../bloc/bloc_business.dart';
import '../../bloc/bloc_qr_scan.dart';
import '../organisms/dialog_qr_capture_body.dart';

class QrTemplate extends StatefulWidget {
  const QrTemplate({super.key});

  @override
  State<QrTemplate> createState() => _QrTemplateState();
}

class _QrTemplateState extends State<QrTemplate> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocQrScan, QrState>(
      builder: (context, state) {
        MobileScannerController mobileScannerController =
            MobileScannerController();
        return Scaffold(
          body: Stack(fit: StackFit.expand, children: [
            state is QrScanCameraOpened
                ? ScanCameraScreen(
                    mobileScannerController: mobileScannerController)
                : ScanResultScreen(
                    mobileScannerController: mobileScannerController),
          ]),
          backgroundColor: Colors.white,
        );
      },
    );
  }
}

class ScanCameraScreen extends StatefulWidget {
  const ScanCameraScreen({super.key, required this.mobileScannerController});
  final MobileScannerController mobileScannerController;

  @override
  State<ScanCameraScreen> createState() => _ScanCameraScreenState();
}

class _ScanCameraScreenState extends State<ScanCameraScreen> {
  Future<void> saveScannedQRCode(String qrCodeData, contexto) async {
    BusinessService businessService = BusinessService(context);
    if (qrCodeData == '-1') {
      BlocProvider.of<BlocQrScan>(context).closeCamera("-1");
      return;
    }
    await businessService.validateQrCamera(qrCodeData);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
            ),
          ),
          Center(
            child: MobileScanner(
              controller: widget.mobileScannerController,
              overlay: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                    width: 2.0,
                  ),
                ),
              ),
              errorBuilder: (context, error, stackTrace) => Center(
                  child: Text(
                      translation(context)!.failed_to_get_platform_version),),
              onDetect: (barcode) {
                print("barcode ${barcode.barcodes.first.displayValue}");
                BlocProvider.of<BlocQrScan>(context)
                    .closeCamera("${barcode.barcodes.first.displayValue}");
              },
            ),
          ),
          // Este es el cuadro de enfoque
          Positioned(
            top: 0,
            left: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * 0.15,
                      color: Colors.black.withOpacity(0.2),
                      child: GestureDetector(
                        onTap: () {
                          NavigationService().navigateTo(
                            context,
                            BlocProvider.value(
                              value: BlocProvider.of<BlocBusiness>(context),
                              child: const QrEntryManualPage(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 12.0, top: 24.0),
                              child: TextAtom(
                                text: translation(context)!.manual_qr_entry,
                                color: Theme.of(context).colorScheme.background,
                                weight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 24.0, top: 29.0),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Theme.of(context).colorScheme.background,
                                size: 16.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.7,
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.7,
                          color: Colors.black.withOpacity(0.2),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.width * 0.7,
                          color: Colors.transparent,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.7,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScanResultScreen extends StatefulWidget {
  const ScanResultScreen({super.key, required this.mobileScannerController});
  final MobileScannerController mobileScannerController;

  @override
  State<ScanResultScreen> createState() => _ScanResultScreenState();
}

class _ScanResultScreenState extends State<ScanResultScreen> {
  String scannedResult = "";
  bool isQrSent = false;
  bool isVisible = true;

  void showPopupQrCapture(BuildContext contexto, BlocBusiness blocBusiness) {
    showDialog(
      context: context,
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
              child: DialogQrCaptureBody(scannedResult: scannedResult)),
        );
      },
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showPopupQrCapture(context, BlocProvider.of<BlocBusiness>(context));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomScrollView(
        slivers: [
          CustomSliverAppbar(
            title: translation(context)!.scanned_qr_code,
            leading: false,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<BlocQrScan, QrState>(
                          builder: (context, state) {
                        scannedResult = state.qrScanned;
                        if (state.qrScanned != "-1") {}
                        return QrImageView(
                          data: state.qrScanned,
                          version: QrVersions.auto,
                          size: 200.0,
                        );
                      }),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(translation(context)!.scanned_qr_code,
                        style: const TextStyle(fontSize: 20))
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    BlocBuilder<BlocQrScan, QrState>(builder: (context, state) {
                      return Text(state.qrScanned,
                          style: const TextStyle(fontSize: 16));
                    })
                  ]),
                  const SizedBox(height: 40),
                  BlocBuilder<BlocQrScan, QrState>(
                    builder: (context, state) {
                      return MyGradientBtn(
                        onPressed: () async {
                          BlocProvider.of<BlocQrScan>(context).openCamera();
                          //widget.mobileScannerController.start();
                        },
                        text: translation(context)!.scan_again,
                        icon: "assets/icons/scanned.svg",
                      );
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
