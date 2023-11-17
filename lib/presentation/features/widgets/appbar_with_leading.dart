import 'package:flutter/material.dart';
import 'package:qrcash/presentation/atoms/big_title_component.dart';

class MyAppBarWithLeading{
  String title;
  MyAppBarWithLeading({required this.title});
  getAppBar(){
    return AppBar(
      title: BigTitleComponent(title).render(),

      backgroundColor: Colors.red,
      automaticallyImplyLeading: true,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset(
                "assets/icons/isotipo.png",
                height: 30,
              ),
            ),
          ],
        )
      ],

    );
  }
}