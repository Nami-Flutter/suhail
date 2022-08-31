import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/views/shared/chat/cubit.dart';
import 'package:soheel_app/views/shared/chat/units/field_section.dart';
import 'package:soheel_app/widgets/app/loading.dart';
import 'package:soheel_app/widgets/app/message_bubble.dart';
import 'package:soheel_app/widgets/app_bar.dart';
import 'package:soheel_app/widgets/my_text.dart';
import 'package:soheel_app/widgets/text_form_field.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key, required this.title, required this.tripID, required this.receiverID}) : super(key: key);

  final String title;
  final String tripID;
  final String receiverID;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(tripID: tripID, receiverID: receiverID)..getChat(),
      child: Scaffold(
        appBar: appBar(
          title: title,
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () => ChatCubit.of(context).getChat(false),
                  icon: Icon(Icons.refresh),
                );
              }
            ),
          ]
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: BlocBuilder<ChatCubit, ChatStates>(
            builder: (context, state) {
              final cubit = ChatCubit.of(context);
              if (state is ChatLoading) {
                return Loading();
              }
              final messages = cubit.chatModel?.chatDetails ?? [];
              return Column(
                children: [
                  Expanded(
                    child: messages.isEmpty ? Center(child: MyText(title: "لا توجد رسائل بعد"),) : ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return MessageBubble(
                          type: message.messageType ?? 'text',
                          attachment: message.messageFile,
                          date: '',
                          isMe: message.fromId == AppStorage.customerID.toString(),
                          message: message.messageTxt,
                          senderName: '',
                        );
                      },
                    ),
                  ),
                  FieldSection(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
