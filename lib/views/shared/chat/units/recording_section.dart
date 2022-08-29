import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../constants.dart';
import '../cubit.dart';

class ChatRecordingSection extends StatelessWidget {
  const ChatRecordingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = ChatCubit.of(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: RotatedBox(quarterTurns: 6, child: Icon(Icons.send, color: kPrimaryColor,)),
            onPressed: () => cubit.stopRecording(true),
          ),
          _Timer(),
          IconButton(
            icon: Icon(FontAwesomeIcons.trash, color: Colors.red, size: 20,),
            onPressed: () => cubit.stopRecording(false),
          ),
        ],
      ),
    );
  }
}

class _Timer extends StatefulWidget {
  const _Timer({Key? key}) : super(key: key);

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<_Timer> {

  late Timer _timer;
  int _seconds = 0;
  int _minutes = 0;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 59) {
        _minutes++;
        _seconds = 0;
      } else {
        _seconds++;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text('${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
    );
  }
}