import 'package:contacts_service/contacts_service.dart';

import '../constants.dart';

class MyContact {
  String displayName, givenName, middleName, familyName;
  List<String> phoneNumbers;

  MyContact({
    this.displayName = "",
    this.givenName = "",
    this.familyName = "",
    this.middleName = "",
    this.phoneNumbers = const [],
  });

  static MyContact convertContactToMyContact(Contact contact) {
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

    return MyContact(
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
