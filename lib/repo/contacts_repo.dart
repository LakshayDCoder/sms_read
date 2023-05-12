import 'dart:developer';

import 'package:contacts_service/contacts_service.dart';

import '../modals/contact_modal.dart';

class ContactRepo {
  // Responsible for sending us raw data

  Future<List<ContactModal>> getAllContacts() async {
    List<Contact> tempContacts = await ContactsService.getContacts();
    List<ContactModal> con = tempContacts
        .map((c) => ContactModal.convertContactToMyContact(c))
        .toList();
    log("Got ${con.length} contacts");
    return con;
  }
}
