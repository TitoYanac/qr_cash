import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_save_scan/domain/constants/language_constants.dart';

import '../../core/services/navigation_service.dart';
import '../../features/business/pages/home_screen.dart';
import '../atoms/curve_painter.dart';

class CustomSliverAppbar extends StatefulWidget {
  const CustomSliverAppbar(
      {super.key, required this.title, required this.leading});
  final String title;
  final bool leading;

  @override
  State<CustomSliverAppbar> createState() => _CustomSliverAppbarState();
}

class _CustomSliverAppbarState extends State<CustomSliverAppbar> {
  @override
  Widget build(BuildContext context) {
    double liquidBackgroundHeight = 387;
    double width = MediaQuery.of(context).size.width;
    double liquidBackgroundWidth = 951;
    double heightLiquid =
        liquidBackgroundHeight / liquidBackgroundWidth * width;

    return SliverAppBar(
      expandedHeight: heightLiquid,
      backgroundColor: Colors.transparent,
      leading: (widget.leading)?GestureDetector(
        onTap: () {
          if(widget.title == translation(context)!.profile_details){
            NavigationService().navigateToAndRemoveUntil(
              context,
              const HomeScreen(index: 4,),
            );
          }else{
            Navigator.pop(context);
          }
        },
        child: Container(
          height: 56.0,
          color: Colors.transparent,
          child: Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Theme.of(context).colorScheme.background,
                    size: 36.0 * width / liquidBackgroundWidth,
                  ),
                ),
              ],
            ),
          ),
        ),
      ):null,
      pinned: true,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double offset = constraints.biggest.height;
          return Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(painter: CurvePainter()),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: width,
                  height: 56.0,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color.fromRGBO(227, 0, 20, 1),
                        Color.fromRGBO(191, 0, 10, 1)
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: offset > 100.0 ? offset - 100.0 : 0.0,
                left: 24.0,
                child: Container(
                  height: 56.0,
                  width: offset > 100.0 ?MediaQuery.of(context).size.width*0.5*offset/100:MediaQuery.of(context).size.width*0.5,
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6,
                  ),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              widget.title[0].toUpperCase() + widget.title.substring(1),
                              style: GoogleFonts.montserrat(
                                fontSize: 64.0 * width / liquidBackgroundWidth,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if(offset > 128.0 && widget.leading)
              Positioned(
                //top: offset > 100.0 ? offset-100.0 : 0.0,
                top: 0.0,
                left: 24.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 56.0,
                    color: Colors.transparent,
                    child: Center(
                      child: Row(
                        children: [
                          Text(
                            translation(context)!.back_label,
                            style: GoogleFonts.montserrat(
                              fontSize: 36.0 * width / liquidBackgroundWidth,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 24.0,
                top: 0.0,
                child: Container(
                  color: Colors.transparent,
                  height: 56.0,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/logo_listoil.svg',
                      height: 42 * width / liquidBackgroundWidth,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.background,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      stretch: true,
    );
  }
}
