import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcash/presentation/core/services/business_service.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../../../domain/models/dashboard/qr_response.dart';
import '../../../auth/components/molecules/my_button_submit.dart';
import '../../../bloc/btn/bloc_btn_state.dart';
import '../../../bloc/btn/bloc_btn.dart';
import '../organisms/data_widget.dart';

class QrTemplate extends StatefulWidget {
  const QrTemplate({super.key});

  @override
  State<QrTemplate> createState() => _QrTemplateState();
}

class _QrTemplateState extends State<QrTemplate> {
  late final MobileScannerController mobileScannerController;
  String _scanBarcode = '';
  bool _showCamera = true;
  bool _showResult = false;

  QrResponse? qrResponse;
  @override
  void initState() {
    super.initState();
    mobileScannerController = MobileScannerController();
    scanQR(context);
  }
/*

  Future<void> scanQR(contexto) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
    } on PlatformException {
      barcodeScanRes = translation(context)!.failed_to_get_platform_version;
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      _showCamera = false;
    });
    await   saveScannedQRCode(barcodeScanRes, contexto);
  }
*/

  // Save the scanned QR code to SharedPreferences and fetch additional data using QrRepository
  Future<void> saveScannedQRCode(String qrCodeData, contexto) async {
    BusinessService businessService = BusinessService(context);
    if (qrCodeData == '-1') {
      print("No se ha tomado ninguna foto de código QR");
      setState(() {
        _showResult = false;
      });
      return;
    }
      final value = await businessService.validateQrCamera(qrCodeData);

      if (value != null) {
        final val = await businessService.registerQr(value);

        setState(() {
          qrResponse = value;
          _showResult = mounted && val;
        });
      } else {
        setState(() {
          _showResult = false;
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showCamera ? _buildScannerWidget() : _buildScannedResultWidget(),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildScannerWidget() {
    return Column(
      children: [
        Expanded(
          child: MobileScanner(
            controller: mobileScannerController,
            errorBuilder: (context, error, stackTrace)=>Center(child: Text(translation(context)!.failed_to_get_platform_version)),
            onDetect: (barcode) {
              setState(() {
                _scanBarcode = barcode.barcodes.first.rawValue ?? '-1';
                _showCamera = false;
                _showResult = false;
              });
              saveScannedQRCode(_scanBarcode, context);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildScannedResultWidget() {
    return ListView(
      children: [
        const SizedBox(
          height: 32,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: _scanBarcode,
              version: QrVersions.auto,
              size: 200.0,
            ),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(translation(context)!.scanned_qr_code,
              style: const TextStyle(fontSize: 20))
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(_scanBarcode, style: const TextStyle(fontSize: 16))
        ]),
        const SizedBox(height: 40),
        BlocBuilder<MyBlocBtn, MyStateBtn>(
          builder: (context, state) {
            print("${translation(context)!.state}: ${state.statusButton}");
            return MyButtonSubmit(
              onButtonPressed: () async {
                setState(() {
                  _showCamera = false;
                  _scanBarcode = translation(context)!.unknown;
                  _showResult = false;
                });
                await scanQR(context).then((value) =>
                    BlocProvider.of<MyBlocBtn>(context).cancelFetch());
              },
              label: translation(context)!.scan_again,
              imagenIcon: const Icon(
                Icons.qr_code_scanner,
                color: Colors.red,
              ),
            );
          },
        ),
        const SizedBox(
          height: 40,
        ),
        if (_scanBarcode == '-1') Container(),
        if (_scanBarcode != '-1' && qrResponse == null && _showResult)
          const Center(
            child: CircularProgressIndicator(),
          ),
        if (qrResponse != null && _showResult)
          DataWidget(
            qrResponse: qrResponse!,
          ),
      ],
    );
  }

  Future<void> scanQR(BuildContext context) async{
    print("hola");
  }
}
