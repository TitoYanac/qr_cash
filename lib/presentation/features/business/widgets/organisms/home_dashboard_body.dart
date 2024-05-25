import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../domain/constants/language_constants.dart';
import '../../../../widgets/atoms/text_atom.dart';
import '../../bloc/bloc_business.dart';
import '../molecules/row_text_molecule.dart';
import 'column_organism.dart';

class HomeDashboardBody extends StatefulWidget {
  const HomeDashboardBody({super.key});

  @override
  State<HomeDashboardBody> createState() => _HomeDashboardBodyState();
}

class _HomeDashboardBodyState extends State<HomeDashboardBody> {
  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          //HomeDisclaimerBody(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: pageSize.width * 0.8,
                    margin: const EdgeInsets.only(top: 46),
                    padding: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.5), // Color de la sombra
                          spreadRadius: 5, // Radio de expansión de la sombra
                          blurRadius: 10, // Radio de desenfoque de la sombra
                          offset: const Offset(0,
                              3), // Desplazamiento de la sombra (horizontal, vertical)
                        ),
                      ],
                    ),
                    child: BlocBuilder<BlocBusiness, BlocBusinessState>(
                      builder: (context, state) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              width: pageSize.width * 0.8,
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color: Colors.grey.withOpacity(0.5))),
                              ),
                              child: Center(
                                child: TextAtom(
                                    text: AppLocalizations.of(context)
                                        ?.todays_transactions,
                                    color: Colors.black,
                                    weight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color: Colors.grey.withOpacity(0.5))),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ColumnOrganism(
                                    firstWidget: TextAtom(
                                      text: state.scanned.toString(),
                                      color: Colors.black,
                                      weight: FontWeight.bold,
                                    ),
                                    secondWidget: TextAtom(
                                      text: translation(context)!.scanned,
                                      color: Colors.black,
                                    ),
                                  ),
                                  ColumnOrganism(
                                    firstWidget: TextAtom(
                                      text: state.pending.toString(),
                                      color: Colors.black,
                                      weight: FontWeight.bold,
                                    ),
                                    secondWidget: TextAtom(
                                      text:
                                          AppLocalizations.of(context)?.offline,
                                      color: Colors.black,
                                    ),
                                  ),
                                  ColumnOrganism(
                                    firstWidget: TextAtom(
                                      text: state.accepted.toString(),
                                      color: Colors.black,
                                      weight: FontWeight.bold,
                                    ),
                                    secondWidget: TextAtom(
                                      text: AppLocalizations.of(context)
                                          ?.accepted,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color: Colors.grey.withOpacity(0.5))),
                              ),
                              child: RowTextMolecule(
                                firstText: translation(context)!.money_earned,
                                secondText: " ₹",
                                thirdText: state.todayWon.toString(),
                                weight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              width: pageSize.width * 0.8,
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color: Colors.grey.withOpacity(0.5))),
                              ),
                              child: Center(
                                child: TextAtom(
                                  text: AppLocalizations.of(context)?.report,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
