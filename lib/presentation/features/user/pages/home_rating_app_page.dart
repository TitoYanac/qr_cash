import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../atoms/build_text_field.dart';
import '../../auth/components/molecules/my_button_submit.dart';
import '../../bloc/btn/bloc_btn_state.dart';
import '../../bloc/btn/bloc_btn.dart';

class HomeRatingAppPage extends StatefulWidget {
  const HomeRatingAppPage({super.key});

  @override
  State<HomeRatingAppPage> createState() => _HomeRatingAppPageState();
}

class _HomeRatingAppPageState extends State<HomeRatingAppPage> {
  double _rating = 0;
  final String _comment = '';

  final TextEditingController _comentarios = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                translation(context)!.rate_our_app,
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ],
          ),
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
              const SizedBox(height: 16),
BuildTextField(controller: _comentarios, label: "${translation(context)!.write_your_comment}...", hint: '',),

              const SizedBox(
                height: 40,
              ),
              BlocBuilder<MyBlocBtn, MyStateBtn>(
                builder: (context, state) {
                  return MyButtonSubmit(
                    onButtonPressed: () async {

                      await Future.delayed(const Duration(seconds: 2));
                      BlocProvider.of<MyBlocBtn>(context).cancelFetch();
                    },
                    label: translation(context)!.submit,
                  );
                },
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
