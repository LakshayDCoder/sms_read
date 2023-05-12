import 'package:sms_read/modals/contact_modal.dart';
import 'package:sms_read/modals/sms_model.dart';

class ChatRoomModal {
  List<SmsModal> smsList;
  ContactModal contactModal;

  ChatRoomModal({
    required this.contactModal,
    this.smsList = const [],
  });

  toMap() {
    return {
      "contactDetails": contactModal.toMap(),
      "smsList": smsList.map((e) => e.toMap()).toList(),
    };
  }
}
