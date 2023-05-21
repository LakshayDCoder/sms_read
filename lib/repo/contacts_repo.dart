import 'dart:developer';

import 'package:contacts_service/contacts_service.dart';

import '../modals/contact_modal.dart';

class ContactRepo {
  Future<List<ContactModal>> getAllContacts() async {
    List<Contact> tempContacts = await ContactsService.getContacts();
    List<ContactModal> con = tempContacts
        .map((c) => ContactModal.convertContactToMyContact(c))
        .toList();
    log("Got ${con.length} contacts");
    return con;
  }

  // Future sendUniqueNumbersToDB(List<ContactModal> list) async {
  //   final CollectionReference colRef = firestore.collection(numbersCollection);

  //   for (ContactModal c in list) {
  //     await colRef.doc().set(c.toMap());
  //     log("added ${c.phoneNumbers} in db");
  //   }
  // }
}
