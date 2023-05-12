import 'package:flutter/material.dart';
import 'package:sms_read/core/chat_room_controller.dart';
import 'package:sms_read/modals/chat_room_modal.dart';
import 'package:sms_read/pages/chat_detail_screen.dart';
import 'package:sms_read/utils/locator.dart';

import '../utils/constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatRoomModal> rooms = [];
  bool loading = true;

  getChatRooms() async {
    rooms = await locator.get<ChatRoomController>().createChatRooms();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getChatRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text("Loading messages"),
                  SizedBox(height: 8),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  loading = true;
                });
                getChatRooms();
              },
              child: rooms.isNotEmpty
                  ? ListView.builder(
                      itemCount: rooms.length,
                      itemBuilder: (context, i) {
                        return Column(
                          children: <Widget>[
                            const Divider(height: 10.0),
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) =>
                                        ChatDetailScreen(roomModal: rooms[i]),
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                backgroundColor: const Color(0xFFF4C095),
                                child: Text(
                                  rooms[i].contactModal.displayName[0],
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      rooms[i].contactModal.displayName,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    normalizeDate(rooms[i].smsList.first.time),
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
                                  rooms[i].smsList.first.message,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  : const Center(
                      child: Text("No Messages Found"),
                    ),
            ),
    );
  }
}
