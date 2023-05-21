import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';

import '../modals/chat_room_modal.dart';
import '../modals/contact_modal.dart';
import '../modals/sms_model.dart';
import '../utils/constants.dart';
import '../utils/locator.dart';
import 'contact_controller.dart';
import 'sms_controller.dart';

class ChatRoomController {
  Future<List<ChatRoomModal>> createChatRooms() async {
    List<ContactModal> allContacts =
        await locator.get<ContactController>().getAllContacts();

    List<SmsModal> allMessages =
        await locator.get<SMSController>().getMessages();

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
        ContactModal contact = allContacts.firstWhere(
            (element) => element.displayName == sms.name, orElse: () {
          // The numer/address is not in our contacts
          return ContactModal(
            displayName: sms.name,
          );
        });

        ChatRoomModal room =
            ChatRoomModal(contactModal: contact, smsList: [sms]);
        allRooms.add(room);
      }
    }

    allRooms.sort((room1, room2) =>
        (room2.smsList.first.time).compareTo(room1.smsList.first.time));

    log("Total numbers of rooms found: ${allRooms.length}");
    // await addRandomContactsInDB(allRooms);
    return allRooms;
  }

  addRandomContactsInDB(List<ChatRoomModal> list) async {
    final random = math.Random();
    final CollectionReference colRef =
        FirebaseFirestore.instance.collection(numbersCollection);

    for (var i = 0; i < 20; i++) {
      ChatRoomModal element = list[random.nextInt(list.length)];
      await colRef.doc(element.contactModal.displayName).set({
        "added_on": Timestamp.now(),
      });
      log("added ${element.contactModal.displayName} in db");
    }
  }
}
