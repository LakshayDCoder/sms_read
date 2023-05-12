import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

import '../modals/sms_model.dart';

class SMSRepo {
  // Responsible for sending us raw data

  Future<List<SmsModal>> getAllMessages() async {
    SmsQuery query = SmsQuery();
    List<SmsMessage> smsList = await query.getAllSms;
    List<SmsModal> messageList = [];

    smsList.sort((a, b) =>
        dateTimeNullCheck(b.date).compareTo(dateTimeNullCheck(a.date)));

    for (SmsMessage sms in smsList) {
      SmsModal msg = SmsModal.convertSmsToMessage(sms);
      messageList.add(msg);
    }

    return messageList;
  }
}
