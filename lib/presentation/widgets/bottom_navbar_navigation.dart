import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/business/bloc/bloc_bottom_navigation_bar_state.dart';
import '../features/business/bloc/my_bloc_bottom_navigation_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBlocBottomNavigationBar, MyBottomNavigationBarState>(
        bloc: BlocProvider.of<MyBlocBottomNavigationBar>(context),
        builder: (context, MyBottomNavigationBarState state) {
          int indexPage = state.page;
          Color selectedColor = Theme.of(context).colorScheme.background;
          Color unselectedColor = Theme.of(context).colorScheme.background;
          Color transparentColor = (indexPage == 2)?Theme.of(context).colorScheme.secondary:Colors.transparent;
          return CurvedNavigationBar(
            //key: _bottomNavigationKey,
            index: indexPage,
            height: 60.0,

            items: <Widget>[
              Icon(
                Icons.home,
                size: 30,
                color: indexPage == 0 ? selectedColor : unselectedColor,
              ),
              Icon(
                Icons.list,
                size: 30,
                color: indexPage == 1 ? selectedColor : unselectedColor,
              ),
              Icon(
                Icons.qr_code_scanner,
                size: 30,
                color: indexPage == 2 ? selectedColor : unselectedColor,
              ),
              Icon(
                Icons.video_library,
                size: 30,
                color: indexPage == 3 ? selectedColor : unselectedColor,
              ),
              Icon(
                Icons.perm_identity,
                size: 30,
                color: indexPage == 4 ? selectedColor : unselectedColor,
              ),
            ],
            //color: const Color.fromRGBO(234, 238, 250, 1),
            color: Theme.of(context).colorScheme.primary,
            buttonBackgroundColor: Theme.of(context).colorScheme.secondary,
            backgroundColor: (indexPage == 0)
                ? transparentColor
                : (indexPage == 1)
                ? transparentColor
                : (indexPage == 2)
                ? transparentColor
                : (indexPage == 3)
                ? transparentColor
                : (indexPage == 4)
                ? transparentColor
                : selectedColor,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              BlocProvider.of<MyBlocBottomNavigationBar>(context).toPage(index);
            },
            letIndexChange: (index) => true,
          );
        });
  }
}
