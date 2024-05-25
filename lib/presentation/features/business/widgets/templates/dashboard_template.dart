import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../../core/services/authentication_service.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../widgets/atoms/curve_painter.dart';
import '../../../../widgets/atoms/text_atom.dart';
import '../../../user/bloc/bloc_user.dart';
import '../../../user/pages/composite_faqs.dart';
import '../../../user/pages/custom_care_page.dart';
import '../../bloc/bloc_business.dart';

class DashboardTemplate extends StatefulWidget {
  const DashboardTemplate({
    super.key,
  });

  @override
  State<DashboardTemplate> createState() => _DashboardTemplateState();
}

class _DashboardTemplateState extends State<DashboardTemplate> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                  Color.fromRGBO(227, 0, 20, 1),
                  Color.fromRGBO(191, 0, 10, 1)
                ])),
              )),
              title: Row(children: [
                /*InkWell(
                  onTap: () {
                    NavigationService().navigateTo(
                      context,
                      CompositeFaqs(
                        username: BlocProvider.of<BlocUser>(context)
                                .state
                                .personData
                                ?.name ??
                            "<username>",
                      ),
                    );
                  },
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    height: 30,
                    width: 30,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.background,
                        width: 2.0,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Icon(
                        Icons.question_mark,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                InkWell(
                  onTap: () {
                    NavigationService()
                        .navigateTo(context, const CustomCarePage());
                  },
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    height: 30,
                    width: 30,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.background,
                        width: 2.0,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/customer_care.svg",
                      fit: BoxFit.contain,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.background,
                          BlendMode.srcIn),
                    ),
                  ),
                ),*/
                const Spacer(),
                SvgPicture.asset(
                  "assets/icons/logo_listoil.svg",
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.background,
                      BlendMode.srcIn),
                ),
              ]),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CustomPaint(painter: CurvePainter()),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 24.0, bottom: 64.0, right: 24.0, top: 48.0),
                          child: BlocBuilder<BlocBusiness, BlocBusinessState>(
                              builder: (context, state) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                RowLabelDashboard(
                                    text: translation(context)!.total_loaded,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                                RowValueDashboard(
                                    value: state.loaded,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                                RowLabelDashboard(
                                    text: translation(context)!.total_redeemed,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                                RowValueDashboard(
                                    value: state.redeemed,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(
                      left: 24.0, right: 24.0, top: 0.0, bottom: 24.0),
                  child: BlocBuilder<BlocBusiness, BlocBusinessState>(
                      builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RowLabelDashboard(
                            text: translation(context)!.todays_transactions,
                            color: Theme.of(context).colorScheme.secondary),
                        TodayContentDashboard(
                          scanned: state.scanned.toString(),
                          accepted: state.accepted.toString(),
                          pending: state.pending.toString(),
                        ),
                        RowLabelDashboard(
                            text: translation(context)!.money_earned,
                            color: Theme.of(context).colorScheme.secondary),
                        RowValueDashboard(
                            value: state.todayWon,
                            color: Theme.of(context).colorScheme.secondary,
                            weight: FontWeight.bold),
                      ],
                    );
                  }),
                ),
              ]),
            ),
          ],
        ),
        onRefresh: () async {
          await AuthenticationService(context).fetchBusinessDataInitial().then(
              (value) =>
                  BlocProvider.of<BlocBusiness>(context).refreshBusiness());
        });
  }
}

class RowLabelDashboard extends StatefulWidget {
  const RowLabelDashboard({super.key, required this.text, required this.color});
  final String text;
  final Color color;

  @override
  State<RowLabelDashboard> createState() => _RowLabelDashboardState();
}

class _RowLabelDashboardState extends State<RowLabelDashboard> {
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      TextAtom(
        text: widget.text,
        color: widget.color,
      ),
      const SizedBox(
        width: 24.0,
      ),
      Expanded(
        child: Container(
          width: double.infinity,
          height: 1.0,
          color: widget.color,
        ),
      ),
    ]);
  }
}

class RowValueDashboard extends StatefulWidget {
  const RowValueDashboard(
      {super.key, required this.value, required this.color, this.weight});
  final String value;
  final Color color;
  final FontWeight? weight;

  @override
  State<RowValueDashboard> createState() => _RowValueDashboardState();
}

class _RowValueDashboardState extends State<RowValueDashboard> {
  late String value;
  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RowValueDashboard oldWidget) {
    if (widget.value != value) {
      setState(() {
        value = widget.value;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RichText(
          text: TextSpan(
            text: "₹ ",
            style: GoogleFonts.montserrat(
              fontWeight:
                  (widget.weight != null) ? widget.weight : FontWeight.normal,
              color: widget.color,
              fontSize: 24.0,
              decoration: TextDecoration.none,
              decorationStyle: TextDecorationStyle.solid,
            ),
            children: <TextSpan>[
              TextSpan(
                text: "${value.split(".").first}.",
                style: GoogleFonts.montserrat(
                  fontWeight: (widget.weight != null)
                      ? widget.weight
                      : FontWeight.normal,
                  color: widget.color,
                  fontSize: 32.0,
                ),
              ),
              TextSpan(
                text: value.split(".").last,
                style: GoogleFonts.montserrat(
                  color: widget.color,
                  fontWeight: (widget.weight != null)
                      ? widget.weight
                      : FontWeight.normal,
                  fontSize: 24.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TodayContentDashboard extends StatefulWidget {
  const TodayContentDashboard(
      {super.key,
      required this.scanned,
      required this.accepted,
      required this.pending});
  final String scanned;
  final String accepted;
  final String pending;

  @override
  State<TodayContentDashboard> createState() => _TodayContentDashboardState();
}

class _TodayContentDashboardState extends State<TodayContentDashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ColumnDataDashboard(
            icon: "assets/icons/scanned.png",
            text: translation(context)!.scanned,
            value: widget.scanned,
          ),
          ColumnDataDashboard(
            icon: "assets/icons/accepted.png",
            text: translation(context)!.accepted,
            value: widget.accepted,
          ),
          ColumnDataDashboard(
            icon: "assets/icons/pending.png",
            text: translation(context)!.pending,
            value: widget.pending,
          ),
        ],
      ),
    );
  }
}

class ColumnDataDashboard extends StatefulWidget {
  const ColumnDataDashboard(
      {super.key, required this.icon, required this.text, required this.value});
  final String icon;
  final String text;
  final String value;

  @override
  State<ColumnDataDashboard> createState() => _ColumnDataDashboardState();
}

class _ColumnDataDashboardState extends State<ColumnDataDashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.icon,
              width: MediaQuery.of(context).size.width * 0.08,
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextAtom(
              text: widget.text,
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextAtom(
              text: widget.value,
              size: 24.0,
              weight: FontWeight.bold,
            ),
          ],
        ),
      ],
    );
  }
}
