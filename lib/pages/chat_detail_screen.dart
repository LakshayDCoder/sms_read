import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_read/core/check_number_controller.dart';
import 'package:sms_read/modals/chat_room_modal.dart';
import 'package:sms_read/utils/constants.dart';
import 'package:sms_read/utils/locator.dart';

class ChatDetailScreen extends StatefulWidget {
  final ChatRoomModal roomModal;
  const ChatDetailScreen({super.key, required this.roomModal});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  bool isNumberSafe = true;

  @override
  void initState() {
    super.initState();
    locator
        .get<CheckNumberController>()
        .isNumberSafe(widget.roomModal.contactModal.displayName)
        .then((value) {
      setState(() {
        isNumberSafe = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 245, 230),
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.roomModal.contactModal.displayName),
            const SizedBox(width: 10),
            if (!isNumberSafe)
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: const Text(
                  'Not Safe',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ),
          ],
        ),
      ),
      body: ListView(
        reverse: true,
        children: widget.roomModal.smsList.map((e) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: LayoutBuilder(builder: (context, constraints) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    // width: constraints.maxWidth * 0.5,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    constraints:
                        BoxConstraints(maxWidth: constraints.maxWidth * 0.77),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SelectableText(
                          e.message,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          normalizeDate(e.time),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
