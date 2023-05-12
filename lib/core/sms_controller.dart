import 'package:sms_read/utils/locator.dart';

import '../modals/sms_model.dart';
import '../repo/sms_repo.dart';

class SMSController {
  Future<List<SmsModal>> getMessages() async {
    List<SmsModal> mess = await locator.get<SMSRepo>().getAllMessages();
    mess.sort((a, b) => (b.time).compareTo(a.time));
    return mess;
  }
}
