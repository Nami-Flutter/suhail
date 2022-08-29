import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/views/shared/chat/cubit.dart';
import 'package:soheel_app/views/shared/chat/units/recording_section.dart';

import '../../../../constants.dart';
import '../../../../widgets/text_form_field.dart';

class FieldSection extends StatefulWidget {
  const FieldSection({Key? key}) : super(key: key);

  @override
  State<FieldSection> createState() => _FieldSectionState();
}

class _FieldSectionState extends State<FieldSection> {
  @override
  Widget build(BuildContext context) {
    final cubit = ChatCubit.of(context);
    if (cubit.isRecording) {
      return ChatRecordingSection();
    }
    return Row(
      children: [
        InkWell(
          child: Icon(FontAwesomeIcons.solidImage, size: 28, color: kPrimaryColor,),
          onTap: cubit.pickImage,
        ),
        SizedBox(width: 10),
        Flexible(
          child: InputFormField(
            hint: "رسالتك",
            controller: cubit.txController,
            onChanged: (v) {
              setState(() {});
            },
          ),
        ),
        SizedBox(width: 10),
        if (cubit.txController.text.isEmpty)
          InkWell(
            child: Icon(FontAwesomeIcons.microphone, size: 28, color: kPrimaryColor,),
            onTap: cubit.startRecording,
          ),
        if (cubit.txController.text.isNotEmpty)
          InkWell(
            child: Icon(Icons.send, size: 28, color: kPrimaryColor,),
            onTap: cubit.sendMessage,
          ),
      ],
    );
  }
}
