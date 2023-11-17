import 'package:flutter/material.dart';
import 'package:qrcash/domain/models/business/business.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/entities/contact_entity.dart';
import '../../../../domain/constants/language_constants.dart';
import '../../widgets/appbar_with_leading.dart';
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
    contacts = Business.getInstance().contacts?.contacts??[];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
          appBar: MyAppBarWithLeading(title: translation(context)!.customer_support).getAppBar(),
        body: Container(
          margin: const EdgeInsets.only(top: 20),
          child: ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final currentContact = contacts[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 24, // Tamaño del avatar
                    child: Icon(Icons.person),
                  ),
                  title: Text(
                    "${currentContact.Name}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "${currentContact.Mobile}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    Uri uri = Uri.parse('https://wa.me/+91${currentContact.Mobile}/?text="Hi, can you help me?"');
                    //Uri uri = Uri.parse('https://wa.me/+919887137650/?text=Hola');

                    _launchInBrowser(uri);
                  }
                ),
              );
            },
          ),
        )

      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
