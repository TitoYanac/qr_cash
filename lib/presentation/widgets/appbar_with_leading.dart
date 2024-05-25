import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBarWithLeading{
  String title;
  MyAppBarWithLeading({required this.title});
  getAppBar(){
    return AppBar(
      //title: BigTitleComponent(title).render(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: Text(title.toUpperCase(),style: GoogleFonts.nunito(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),)),
        ],
      ),

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
                height: 24,
              ),
            ),
          ],
        )
      ],

    );
  }
}