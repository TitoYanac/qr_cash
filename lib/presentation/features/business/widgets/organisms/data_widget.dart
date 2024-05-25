import 'package:flutter/material.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../../../domain/models/dashboard/qr_response.dart';

class DataWidget extends StatefulWidget {
  final QrResponse qrResponse;

  const DataWidget({super.key, required this.qrResponse});

  @override
  State<DataWidget> createState() => _DataWidgetState();
}

class _DataWidgetState extends State<DataWidget> {
  QrResponse qrdata = QrResponse(
      qr: '',
      from: '',
      to: '',
      statusUser: '',
      messageUser: '',
      amount: '',
      status: '',
      statusSAP: '',
      message: '',
      fecha: '',
      hora: '',
      latitude: '',
      longitude: '',
      localDate: '');
  @override
  void initState() {
    setState(() {
      qrdata = widget.qrResponse;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Row(
              children: [
                Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                          '${"${translation(context)!.scanned_qr_code.split(" ")[0]} ${translation(context)!.scanned_qr_code.split(" ")[1]}"}: \n${qrdata.qr}'),
                    )),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: Text('${translation(context)!.amount}:  ${qrdata.amount}'),
          ),
          const Divider(),
          ListTile(
            title: Text(
                '${translation(context)!.message}:  ${(qrdata.message == "QR Registration Successfully") ? translation(context)!.accepted : qrdata.message}'),
          ),
        ],
      ),
    );
  }
}
