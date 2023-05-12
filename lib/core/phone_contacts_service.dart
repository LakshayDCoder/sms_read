import 'dart:developer';

import 'package:contacts_service/contacts_service.dart';
// import 'package:get_it/get_it.dart';

import '../constants.dart';
import '../modals/my_contact_modal.dart';

// final getIt = GetIt.instance;

// serviceLocatorInit() {
//   getIt.registerSingleton<PhoneContacts>(PhoneContacts());
// }

class PhoneContacts {
  static getAllContacts() async {
    List<Contact> tempContacts = await ContactsService.getContacts();
    allContacts = tempContacts
        .map((c) => MyContact.convertContactToMyContact(c))
        .toList();
    log("Got ${allContacts.length} contacts");
    // log(allContacts[69].toMap().toString());
  }
}
