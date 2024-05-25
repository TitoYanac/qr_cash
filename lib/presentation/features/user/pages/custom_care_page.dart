import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../data/entities/contact_entity.dart';
import '../../../../domain/constants/language_constants.dart';
import '../../../../domain/models/business/business.dart';
import '../../../../domain/models/user/user.dart';
import '../../../widgets/atoms/text_atom.dart';
import '../../../widgets/molecules/my_gradient_btn.dart';
import '../../../widgets/organisms/custom_sliver_appbar.dart';

class CustomCarePage extends StatefulWidget {
  const CustomCarePage({super.key});

  @override
  State<CustomCarePage> createState() => _CustomCarePageState();
}

class _CustomCarePageState extends State<CustomCarePage> {
  late List<ContactEntity> contacts;

  @override
  void initState() {
    super.initState();
    contacts = Business.getInstance().contacts?.contacts ?? [];
  }

  @override
  Widget build(BuildContext context) {
    String userName = User.getInstance().personData!.name ;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomSliverAppbar(
              title: translation(context)!.customer_support,
              leading: true,
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/customer_care.svg",width: MediaQuery.of(context).size.width * 0.4,
                      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.shadow.withOpacity(0.5), BlendMode.srcIn),),
                    ],
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextAtom(text: "${translation(context)!.send_us_an_email_at}:")
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextAtom(text: "qrsavescan@listoil.com")
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  MyGradientBtn(
                    text: translation(context)!.send,
                    onPressed: () {
                      sendEmail(
                        toEmail:'qrsavescan@listoil.com',
                        subject:translation(context)!.i_need_support,
                        body: '''
                        <!DOCTYPE html>
                        <html>
                        <head>
                        </head>
                        <body>
                        <p>${translation(context)!.dear_listoil_team},</p>
                        
                        <p>${translation(context)!.my_name_is} $userName ${translation(context)!.and_i_am_writing_to_request_assistance_with_an_issue_i_am_experiencing_in_your_application}</p>
                        
                        <p><strong>[${translation(context)!.provide_more_details_about_your_issue_here_the_more_information_you_provide_the_easier_it_will_be_for_the_listoil_team_to_assist_you_effectively}]</strong></p>
                        
                        <p>${translation(context)!.i_appreciate_your_time_and_attention_in_advance}</p>
                        
                        <p>${translation(context)!.best_regards},<br>
                        $userName</p>
                        </body>
                        </html>
                        ''',
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void sendEmail({required String toEmail,required String subject,required String body}) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: [toEmail],
      isHTML: true,
    );

    await FlutterEmailSender.send(email);
  }
}
