import 'package:contacts_service/contacts_service.dart';

import '../utils/constants.dart';

class ContactModal {
  String displayName, givenName, middleName, familyName;
  List<String> phoneNumbers;

  ContactModal({
    required this.displayName,
    this.givenName = "",
    this.familyName = "",
    this.middleName = "",
    this.phoneNumbers = const [],
  });

  static ContactModal convertContactToMyContact(Contact contact) {
    List<String> ph = [];

    // Get all the phone numbers from a contact
    if (contact.phones != null) {
      if (contact.phones!.isNotEmpty) {
        ph = contact.phones!.map((e) {
          // Remove everything from all phone numbers except numbers
          String v = e.value ?? "";
          v = v.replaceAll(numberRegEx, "");

          return v;
        }).toList();
      }
    }

    // To remove duplicates
    ph = ph.toSet().toList();

    return ContactModal(
      displayName: contact.displayName ?? "",
      givenName: contact.givenName ?? "",
      familyName: contact.familyName ?? "",
      middleName: contact.middleName ?? "",
      phoneNumbers: ph,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "displayName": displayName,
      "givenName": givenName,
      "familyName": familyName,
      "middleName": middleName,
      "phoneNumbers": phoneNumbers,
    };
  }
}
