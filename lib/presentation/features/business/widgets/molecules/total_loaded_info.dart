import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../widgets/atoms/title_roboto16.dart';

class TotalLoadedInfo extends StatefulWidget {
  const TotalLoadedInfo({super.key, required this.loaded});
  final String loaded;
  @override
  State<TotalLoadedInfo> createState() => _TotalLoadedInfoState();
}

class _TotalLoadedInfoState extends State<TotalLoadedInfo> {
  late String _loaded;
  @override
  void initState() {
    _loaded = widget.loaded;
    super.initState();
  }
  @override
  void didUpdateWidget(covariant TotalLoadedInfo oldWidget) {
    if ( oldWidget.loaded != widget.loaded) {
      setState(() {
        _loaded = widget.loaded;
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
              "assets/icons/total_loaded.png",
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: TitleRoboto16(
                title: AppLocalizations.of(context)!.total_loaded),
          ),
          TitleRoboto16(title: "₹ $_loaded")
        ],
      ),
    );

  }
}

