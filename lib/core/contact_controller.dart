import 'dart:developer';

import 'package:sms_read/repo/contacts_repo.dart';
import 'package:sms_read/utils/locator.dart';

import '../modals/contact_modal.dart';

class ContactController {
  List<ContactModal> allContacts = [];

  Future<List<ContactModal>> getAllContacts() async {
    if (allContacts.isEmpty) {
      allContacts = await locator.get<ContactRepo>().getAllContacts();
      // locator.get<ContactRepo>().sendUniqueNumbersToDB(allContacts);
    } else {
      log("Already have ${allContacts.length} contacts");
    }
    return allContacts;
  }
}
