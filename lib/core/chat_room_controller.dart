import 'dart:developer';

import '../modals/chat_room_modal.dart';
import '../modals/contact_modal.dart';
import '../modals/sms_model.dart';
import '../utils/locator.dart';
import 'contact_controller.dart';
import 'sms_controller.dart';

class ChatRoomController {
  Future<List<ChatRoomModal>> createChatRooms() async {
    List<SmsModal> allMessages =
        await locator.get<SMSController>().getMessages();
    List<ContactModal> allContacts =
        await locator.get<ContactController>().getAllContacts();

    List<ChatRoomModal> allRooms = [];

    for (SmsModal sms in allMessages) {
      int possibleRoomsIndex = allRooms.indexWhere((ChatRoomModal e) {
        return e.contactModal.displayName == sms.name;
      });

      if (possibleRoomsIndex > 0) {
        ChatRoomModal room = allRooms[possibleRoomsIndex];

        List<SmsModal> smsList = room.smsList;

        smsList.add(sms);
      } else {
        ContactModal contact = allContacts
            .firstWhere((element) => element.displayName == sms.name);

        ChatRoomModal room =
            ChatRoomModal(contactModal: contact, smsList: [sms]);
        allRooms.add(room);
      }
    }

    log("Total numbers of rooms found: ${allRooms.length}");
    return allRooms;
  }
}
