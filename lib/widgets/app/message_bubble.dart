import 'package:flutter/material.dart';
import 'package:soheel_app/widgets/app/voice_bubble.dart';
import '../../../constants.dart';
import '../image_view.dart';

class MessageBubble extends StatelessWidget {
  final bool isMe;
  final String? message;
  final String date;
  final String senderName;
  final String? attachment;
  final String type;

  MessageBubble({
    required this.message,
    required this.isMe,
    required this.date,
    required this.senderName,
    required this.attachment,
    required this.type
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.topLeft : Alignment.topRight,
      child: UnconstrainedBox(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: sizeFromWidth(3.5),
            maxWidth: sizeFromWidth(1.3),
          ),
          child: GestureDetector(
            onTap: () {
              if (type == 'image') {
                ImageView.show(attachment!);
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(15),
              child: Builder(
                builder: (context) {
                  if (type == 'audio') {
                    return VoiceBubble(
                      isMe: isMe,
                      url: attachment!,
                      key: UniqueKey(),
                    );
                  } else if (type == 'image') {
                    return Image.network(attachment!);
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(senderName, style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          type == 'text' ? (message ?? "") : 'مرفق',
                          style: TextStyle(
                              color: isMe ? kWhiteColor : kDarkGreyColor,
                              fontWeight: FontWeight.w700,
                              // decoration: attachment != null || message?.contains('zoom.us') == true ? TextDecoration.underline : null
                          ),
                        ),
                      ),
                      // Text(date, style:TextStyle(color: isMe ? kWhiteColor : kDarkGreyColor,fontWeight: FontWeight.normal)),
                    ],
                  );
                }
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // borderRadius: BorderRadius.only(
                //   bottomLeft: Radius.circular(20),
                //   bottomRight: Radius.circular(20),
                //   topLeft: Radius.circular(isMe ? 0 : 20),
                //   topRight: Radius.circular(isMe ? 20 : 0),
                // ),
                color: isMe ? kPrimaryColor : Color(0xFFD7E2E8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}