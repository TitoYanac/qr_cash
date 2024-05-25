import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import '../../../domain/constants/language_constants.dart';
import 'text_atom.dart';

class LinkComponent extends StatefulWidget {
  const LinkComponent(
      {super.key, required this.headerMail, required this.bodyMail, required this.username});

  final String headerMail;
  final String bodyMail;
  final String username;

  @override
  State<LinkComponent> createState() => _LinkComponentState();
}

class _LinkComponentState extends State<LinkComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
                        
                        <p>${translation(context)!.my_name_is} ${widget.username} ${translation(context)!.and_i_am_writing_to_request_assistance_with_an_issue_i_am_experiencing_in_your_application}</p>
                        
                        <p>${translation(context)!.i_was_reading_the_following_because_i_need_help_with_it_but_it_is_not_very_clear_to_me}</p>
                        
                        <section style="background-color: #f2f2f2; padding: 20px; border-radius: 5px; margin-bottom: 20px; margin-top: 20px; border: 1px solid #ccc">
                        <p style="font-weight: bold">${widget.headerMail}</p>
                        <div>${widget.bodyMail}</div>
                        </section>
                        
                        <p>${translation(context)!.could_you_please_tell_me_in_more_detail_how_to_solve_my_problem}</p>
                        
                        <p>${translation(context)!.i_appreciate_your_time_and_attention_in_advance}</p>
                        
                        <p>${translation(context)!.best_regards},<br>
                        ${widget.username}</p>
                        </body>
                        </html>
                        ''',
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: TextAtom(
                  text: translation(context)!.need_more_help_contact_by_email,
                  size: 14,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ),
          Icon(Icons.keyboard_arrow_right_sharp,
              size: 20, color: Theme.of(context).colorScheme.primary),
        ],
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
