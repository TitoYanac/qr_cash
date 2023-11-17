import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../../../domain/models/user/user.dart';
import '../../../user/bloc/bloc_user.dart';
import '../../../user/bloc/bloc_user_state.dart';
import '../../../user/components/organism/my_avatar.dart';
import 'dart:core';
class CardBodyUserProfile extends StatefulWidget {
  const CardBodyUserProfile({Key? key}) : super(key: key);

  @override
  State<CardBodyUserProfile> createState() => _CardBodyUserProfileState();
}

class _CardBodyUserProfileState extends State<CardBodyUserProfile> {
  String? _imgUrl = '';

  @override
  void initState() {
    super.initState();
    _updateImageUrl();
  }

  @override
  void didUpdateWidget(CardBodyUserProfile oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateImageUrl();
  }

  void _updateImageUrl() {
    setState(() {
      _imgUrl = User.getInstance().imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocUser, BlocUserState>(
        bloc: BlocProvider.of<BlocUser>(context),
    builder: (context, BlocUserState state) {
      return Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: MyAvatar(size: 100,imageUrl: state.user.imageUrl??''),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ((state.user.personData!.name == '')
                      ? translation(context)!.new_user
                      : state.user.personData!.name),

                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    textStyle: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    )
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 5),
                Text(
                  (state.user.personData!.uMobileID == '')
                      ? '0000000000'
                      : state.user.personData!.uMobileID,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          )
        ],
      );
    });

  }
}

