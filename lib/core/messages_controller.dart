import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

import '../modals/message_model.dart';

Future<List<MessageModel>> getMessageData() async {
  SmsQuery query = SmsQuery();
  List<SmsMessage> smsList = await query.getAllSms;
  List<MessageModel> messageList = [];

  for (SmsMessage sms in smsList) {
    MessageModel msg = MessageModel.convertSmsToMessage(sms);
    messageList.add(msg);
  }

  messageList.sort((a, b) => (b.time).compareTo(a.time));

  return messageList;
}
