import 'package:flutter/material.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../../../domain/models/dashboard/qr_response.dart';
import '../../../../widgets/atoms/composite_component.dart';
import '../../../../widgets/atoms/list_component.dart';

class TabBarQrList extends StatefulWidget {
  const TabBarQrList({super.key, required this.keyword, required this.listQr});
  final String keyword;
  final List<QrResponse> listQr;

  @override
  State<TabBarQrList> createState() => _TabBarQrListState();
}

class _TabBarQrListState extends State<TabBarQrList> {
  List<QrResponse> listqr = [];
  @override
  void initState() {
    super.initState();
    if (widget.keyword == 'today') {
      DateTime fechaHoy = DateTime.now();
      listqr = widget.listQr.where((objeto) {
        if (objeto.localDate == '' || objeto.localDate == null) {
          return false;
        } else {
          var fechaObjeto = (objeto.localDate!.split(" ").first).split("/");
          bool isSameYear = int.tryParse(fechaObjeto[2]) == fechaHoy.year;
          bool isSameMonth = int.tryParse(fechaObjeto[1]) == fechaHoy.month;
          bool isSameDay = int.tryParse(fechaObjeto[0]) == fechaHoy.day;
          return isSameYear && isSameMonth && isSameDay;
        }
      }).toList().reversed.toList();
    } else {
      listqr = widget.listQr.reversed.toList();
    }
  }

  @override
  void didUpdateWidget(covariant TabBarQrList oldWidget) {
    if (oldWidget.listQr != widget.listQr) {
      setState(() {
        listqr = widget.listQr;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (listqr.isNotEmpty) {

      return ListView(
        children: [
          for (int index = listqr.length - 1; index >= 0; index--)
            CompositeComponent(name:
            "(${index+1}) → ${listqr[index].qr!}", children:[
              ListComponent(children:[
                "${translation(context)!.date}: ${listqr[index].localDate?.split(" ").first}",
                "${translation(context)!.status}: ${(listqr[index].message == 'Interchanged') ? translation(context)!.interchanged : (listqr[index].message == 'Pending') ? translation(context)!.pending : (listqr[index].message == 'Offline') ? translation(context)!.offline : listqr[index].message}",
                "${translation(context)!.amount}: ₹ ${listqr[index].amount}",
              ]),
            ]),
        ]
      );
    } else {
      return Container(); // Show loading indicator
    }
  }
}
