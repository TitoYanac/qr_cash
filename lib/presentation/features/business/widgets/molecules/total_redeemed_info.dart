import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../widgets/atoms/title_roboto16.dart';

class TotalRedeemedInfo extends StatefulWidget {
  const TotalRedeemedInfo({super.key, required this.redeemed});
  final String redeemed;

  @override
  State<TotalRedeemedInfo> createState() => _TotalRedeemedInfoState();
}

class _TotalRedeemedInfoState extends State<TotalRedeemedInfo> {
  late String _redeemed;
  @override
  void initState() {
    _redeemed = widget.redeemed;
    super.initState();
  }
  @override
  void didUpdateWidget(covariant TotalRedeemedInfo oldWidget) {
    if (oldWidget.redeemed != widget.redeemed ) {
      setState(() {
        _redeemed = widget.redeemed;
      });
    }
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.transparent,
            width: 60,
            height: 60,
            child: Image.asset(
              "assets/icons/total_redeemed.png",
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: TitleRoboto16(
                title: AppLocalizations.of(context)!.total_redeemed),
          ),
          TitleRoboto16(title: "₹ $_redeemed")
        ],
      ),
    );
  }
}