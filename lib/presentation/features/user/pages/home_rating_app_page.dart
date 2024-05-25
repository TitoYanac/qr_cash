import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../widgets/atoms/build_text_field.dart';
import '../../../widgets/molecules/my_gradient_btn.dart';
import '../../../widgets/organisms/custom_sliver_appbar.dart';

class HomeRatingAppPage extends StatefulWidget {
  const HomeRatingAppPage({super.key});

  @override
  State<HomeRatingAppPage> createState() => _HomeRatingAppPageState();
}

class _HomeRatingAppPageState extends State<HomeRatingAppPage> {
  double _rating = 0;

  final TextEditingController _comentarios = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomSliverAppbar(
                title: translation(context)!.rating, leading: true),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Icon(Icons.thumb_up_alt,size: 120,color: Theme.of(context).colorScheme.shadow.withOpacity(0.5)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          initialRating: _rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              _rating = rating;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    BuildTextField(
                      controller: _comentarios,
                      label: "${translation(context)!.write_your_comment}...",
                      hint: '',
                      enable: false,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    MyGradientBtn(
                      onPressed: () async {
                        String url = "https://play.google.com/store/apps/details?id=com.listoil.qr_save_scan";
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          debugPrint('No se pudo abrir la URL: $url');
                        }
                      },
                      text: translation(context)!.rate_our_app,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
