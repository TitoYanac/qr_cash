import '../../../data/entities/contact_entity.dart';

class Contacts {
  final List<ContactEntity> contacts;

  Contacts({
    required this.contacts,
  });

  void addVideo(ContactEntity contact){
    contacts.add(contact);
  }
}
