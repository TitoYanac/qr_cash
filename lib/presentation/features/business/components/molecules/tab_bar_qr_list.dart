import 'package:flutter/material.dart';
import 'package:qrcash/domain/constants/language_constants.dart';

import '../../../../../domain/models/business/business.dart';
import '../../../../../domain/models/dashboard/qr_response.dart';
import '../../../../atoms/composite_component.dart';
import '../../../../atoms/list_component.dart';

class TabBarQrList extends StatefulWidget {
  const TabBarQrList({Key? key, required this.keyword, required this.business})
      : super(key: key);
  final String keyword;
  final Business business;

  @override
  State<TabBarQrList> createState() => _TabBarQrListState();
}

class _TabBarQrListState extends State<TabBarQrList> {

  List<QrResponse> listqr = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.keyword == 'all') {
      listqr = widget.business.qrAcceptedManager!.Data;
    } else if (widget.keyword == 'today') {
      DateTime fechaHoy = DateTime.now();
      setState(() {
        listqr = widget.business.qrAcceptedManager!.Data.where((objeto) {
          if (objeto.LocalDate == '' || objeto.LocalDate == null) {
            return false;
          } else {
            var fechaObjeto = (objeto.LocalDate!.split(" ").first).split("/");
            print(fechaObjeto);
            bool isSameYear = int.tryParse(fechaObjeto[2]) == fechaHoy.year;
            bool isSameMonth = int.tryParse(fechaObjeto[1]) == fechaHoy.month;
            bool isSameDay = int.tryParse(fechaObjeto[0]) == fechaHoy.day;
            /*print(isSameYear);
          print(isSameMonth);
          print(isSameDay);*/
            print(isSameYear && isSameMonth && isSameDay);
            return isSameYear && isSameMonth && isSameDay;
          }
        }).toList();
      });
    } else if (widget.keyword == 'offline') {
      listqr = widget.business.qrPendingManager!.Data;
    }
    if (listqr.isNotEmpty) {
      setState(() {
        listqr = listqr.reversed.toList();
      }); // Aquí invertimos la lista

      return CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return CompositeComponent(
                    "(${listqr.length - index}) → ${listqr[index].QR!}", [
                  ListComponent([
                    "${translation(context)!.date}: ${listqr[index].LocalDate?.split(" ").first}",
                    /*"Status: ${listqr[index].Status}",
                  "StatusSap: ${listqr[index].StatusSAP}",*/
                    "${translation(context)!.status}: ${(listqr[index].Message == 'Interchanged') ? translation(context)!.interchanged : (listqr[index].Message == 'Pending') ? translation(context)!.pending : (listqr[index].Message == 'Offline') ? translation(context)!.offline : listqr[index].Message}",
                    "${translation(context)!.amount}: ₹ ${listqr[index].Ammount}",
                  ]),
                ]).render();
              },
              childCount: listqr.length,
            ),
          ),
        ],
      );
    } else {
      return Container(); // Show loading indicator
    }
  }
}
