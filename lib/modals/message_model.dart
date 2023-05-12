import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

import '../constants.dart';
import 'my_contact_modal.dart';

class MessageModel {
  final int id;
  final String name;
  final String message;
  final DateTime time;

  MessageModel({
    required this.id,
    required this.name,
    required this.message,
    required this.time,
  });

  static MessageModel convertSmsToMessage(SmsMessage sms) {
    String address = sms.address ?? "";

    List<MyContact> possibleMatches = allContacts.where((element) {
      String tempAddress = address.replaceAll(numberRegEx, "");
      return element.phoneNumbers.contains(tempAddress);
    }).toList();

    String messageAddress = address;

    if (possibleMatches.isNotEmpty) {
      MyContact contact = possibleMatches.first;
      messageAddress = contact.displayName;
    }

    return MessageModel(
      id: sms.id ?? 0,
      name: messageAddress,
      message: sms.body ?? "",
      time: dateTimeNullCheck(sms.date),
    );
  }
}

DateTime dateTimeNullCheck(DateTime? d) {
  if (d != null) {
    return d;
  }
  return DateTime.fromMicrosecondsSinceEpoch(0);
}
