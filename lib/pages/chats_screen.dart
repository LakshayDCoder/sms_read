import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sms_read/core/chat_room_controller.dart';
import 'package:sms_read/core/sms_controller.dart';
import 'package:sms_read/utils/locator.dart';
import 'package:vibration/vibration.dart';

import '../core/contact_controller.dart';
import '../modals/sms_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  List<SmsModal> messages = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getMessages();
  }

  getMessages() async {
    await locator.get<ContactController>().getAllContacts();
    messages = await locator.get<SMSController>().getMessages();
    setState(() {
      loading = false;
    });
    locator.get<ChatRoomController>().createChatRooms();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("Loading messages"),
                CircularProgressIndicator(),
              ],
            ),
          )
        : RefreshIndicator(
            onRefresh: () async {
              setState(() {
                loading = true;
              });
              getMessages();
            },
            child: messages.isNotEmpty
                ? ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, i) {
                      return Dismissible(
                        key: Key(messages[i].id.toString()),
                        background: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20.0),
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        secondaryBackground: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            const Divider(height: 10.0),
                            ExpansionTile(
                              childrenPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 4,
                              ),
                              leading: CircleAvatar(
                                backgroundColor: const Color(0xFFF4C095),
                                child: Text(
                                  messages[i].name[0],
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      messages[i].name,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    normalizeDate(messages[i].time),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Container(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  messages[i].message,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              children: [
                                Text(
                                  messages[i].message,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.0,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    child: const Text(
                                      "Copy",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () async {
                                      await FlutterClipboard.copy(
                                          messages[i].message);

                                      bool? canVibrate =
                                          await Vibration.hasVibrator();

                                      if (canVibrate ?? false) {
                                        Vibration.vibrate(duration: 100);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        onDismissed: (DismissDirection direction) {
                          MethodChannel methodChannel = const MethodChannel(
                            "channels.limitedeternity.com/main",
                          );

                          methodChannel.invokeMethod(
                            "deleteSMS",
                            <String, int>{"smsId": messages[i].id},
                          );

                          List<SmsModal> tempMsgs =
                              List<SmsModal>.from(messages);

                          tempMsgs.removeAt(i);
                          setState(() {
                            messages = tempMsgs;
                          });
                        },
                      );
                    },
                  )
                : const Center(
                    child: Text("No Messages Found"),
                  ),
          );
  }

  String normalizeDate(DateTime? date) {
    if (date != null) {
      return DateFormat('d MMM y - H:m').format(date);
    }
    return "Error";
  }
}
