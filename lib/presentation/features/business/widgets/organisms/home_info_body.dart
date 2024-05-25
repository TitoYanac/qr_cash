import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../bloc/bloc_business.dart';

class HomeInfoBody extends StatefulWidget {
  const HomeInfoBody({super.key});

  @override
  State<HomeInfoBody> createState() => _HomeInfoBodyState();
}

class _HomeInfoBodyState extends State<HomeInfoBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocBusiness, BlocBusinessState>(
      bloc: BlocProvider.of<BlocBusiness>(context),
      builder: (context, BlocBusinessState state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.92,
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              height: 220,
              color: Colors.blue.withOpacity(0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Today income: ",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          "₹ ${state.todayWon}",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(1000),
                                  ),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    "assets/icons/scanned_icon1.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(translation(context)!.scanned),
                                Text(state.scanned.toString()),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  padding: const EdgeInsets.all(20),
                                  margin: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(1000),
                                  ),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    "assets/icons/accepted_icon1.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(translation(context)!.accepted),
                                Text(state.accepted.toString()),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  padding: const EdgeInsets.all(20),
                                  margin: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(1000),
                                  ),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    "assets/icons/offline_icon1.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(translation(context)!.pending),
                                Text(state.pending.toString()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
