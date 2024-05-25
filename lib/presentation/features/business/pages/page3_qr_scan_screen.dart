import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc_qr_scan.dart';
import '../widgets/templates/qr_template.dart';
class QrScanScreen extends StatefulWidget {
  const QrScanScreen({super.key});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocQrScan(),
      child: const QrTemplate(),
    );
  }
}
