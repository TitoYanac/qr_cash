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
      QR: '',
      From: '',
      To: '',
      StatusUser: '',
      MessageUser: '',
      Ammount: '',
      Status: '',
      StatusSAP: '',
      Message: '',
      fecha: '',
      hora: '',
      Latitude: '',
      Longitude: '',
      LocalDate: '');
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
                          '${"${translation(context)!.scanned_qr_code.split(" ")[0]} ${translation(context)!.scanned_qr_code.split(" ")[1]}"}: \n${qrdata.QR}'),
                    )),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: Text('${translation(context)!.amount}:  ${qrdata.Ammount}'),
          ),
          const Divider(),
          ListTile(
            title: Text(
                '${translation(context)!.message}:  ${(qrdata.Message == "QR Registration Successfully") ? translation(context)!.accepted : qrdata.Message}'),
          ),
        ],
      ),
    );
  }
}
