import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:sms_read/core/contact_controller.dart';
import 'package:sms_read/utils/locator.dart';

import '../utils/constants.dart';
import 'contact_modal.dart';

class SmsModal {
  final int id;
  final String name;
  final String message;
  final DateTime time;

  SmsModal({
    required this.id,
    required this.name,
    required this.message,
    required this.time,
  });

  static SmsModal convertSmsToMessage(SmsMessage sms) {
    String address = sms.address ?? "";

    List<ContactModal> allContacts =
        locator.get<ContactController>().allContacts;

    List<ContactModal> possibleMatches = allContacts.where((element) {
      String tempAddress = address.replaceAll(numberRegEx, "");
      return element.phoneNumbers.contains(tempAddress);
    }).toList();

    String messageAddress = address;

    if (possibleMatches.isNotEmpty) {
      ContactModal contact = possibleMatches.first;
      messageAddress = contact.displayName;
    }

    return SmsModal(
      id: sms.id ?? 0,
      name: messageAddress,
      message: sms.body ?? "",
      time: dateTimeNullCheck(sms.date),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "message": message,
      "time": time.toString(),
    };
  }
}

DateTime dateTimeNullCheck(DateTime? d) {
  if (d != null) {
    return d;
  }
  return DateTime.fromMicrosecondsSinceEpoch(0);
}
