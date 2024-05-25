import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_save_scan/presentation/widgets/atoms/text_atom.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../../../domain/models/user/user.dart';
import '../../../user/bloc/bloc_user.dart';
import '../../../user/components/organism/my_avatar.dart';

class CardBodyUserProfile extends StatefulWidget {
  const CardBodyUserProfile({super.key});

  @override
  State<CardBodyUserProfile> createState() => _CardBodyUserProfileState();
}

class _CardBodyUserProfileState extends State<CardBodyUserProfile> {
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocUser, UserState>(
        builder: (BuildContext context, UserState state) {
      return Row(
        children: [
          const Expanded(
            flex: 3,
            child: ProfileImageCard2(),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: (state.personData!.name.isEmpty
                              ? translation(context)!.new_user
                              : state.personData!.name)
                          .split(" ")
                          .first,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 24.0,
                      ),
                      children: [
                        if (state.personData!.name.split(" ").length > 1)
                          TextSpan(
                            text: " ${(state.personData!.name.isEmpty
                                ? translation(context)!.new_user
                                : state.personData!.name)
                                .split(" ")[1]}",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 24.0,
                            ),
                          ),
                      ],
                    ),
                  ),
                  TextAtom(text: "+91 ${state.personData!.uMobileID}"),
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}

class ProfileImageCard2 extends StatefulWidget {
  const ProfileImageCard2({super.key});

  @override
  State<ProfileImageCard2> createState() => _ProfileImageCard2State();
}

class _ProfileImageCard2State extends State<ProfileImageCard2> {
  File? _image;
  Widget? _uploadedImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 3),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,),
          height: 100,
          width: 100,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(child: FittedBox(fit: BoxFit.contain,child: _buildImageWidget(),),),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageWidget() {
    if (_image == null) {
      if (_uploadedImage != null) {
        return _uploadedImage!;
      } else if (User.getInstance().imageUrl != '') {
        //print(User.getInstance().imageUrl);
        return MyAvatar(size: 90, imageUrl: User.getInstance().imageUrl ?? '');
      } else {
        return _buildPlaceholderAvatar();
      }
    } else {
      return ClipOval(
        child: SizedBox(
          width: 180,
          height: 180,
          child: Image.file(
            _image!,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }

  Widget _buildPlaceholderAvatar() {
    return CircleAvatar(
      radius: 90,
      //backgroundColor: Color.fromRGBO(0, 82, 151, 0.2),
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.15),
      child: const Icon(
        Icons.account_circle,
        color: Colors.white,
        size: 180,
      ),
    );
  }
}
