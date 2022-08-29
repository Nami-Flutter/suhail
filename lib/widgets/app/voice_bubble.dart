import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class VoiceBubble extends StatefulWidget {
  final String url;
  final bool isMe;
  VoiceBubble({Key? key, required this.url, required this.isMe}) : super(key: key);

  @override
  _VoiceBubbleState createState() => _VoiceBubbleState();
}

class _VoiceBubbleState extends State<VoiceBubble> with AutomaticKeepAliveClientMixin {

  bool isPlaying = false;
  Duration? _audioDuration;
  Duration? _currentPlayingDuration;
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    initializeAudio();
    super.initState();
  }

  @override
  void dispose() {
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  void initializeAudio() {
    openAudio();
    listenForPlayerState();
    getFullAudioDuration();
    listenForCurrentAudioPosition();
  }

  void openAudio() => assetsAudioPlayer.open(
    // TODO: Should Play from storage
    Audio.network(widget.url),
    autoStart: false,
    showNotification: false,
    headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
    respectSilentMode: false,
    audioFocusStrategy: AudioFocusStrategy.request(resumeAfterInterruption: true, resumeOthersPlayersAfterDone: false),
  );

  void listenForPlayerState() => assetsAudioPlayer.isPlaying.listen((event) {
    if (isPlaying != event && mounted) {
      setState(()=> isPlaying = event);
      // this.updateKeepAlive();
    }
  });

  void getFullAudioDuration() => assetsAudioPlayer.current.listen((event) {
    if(event != null && mounted) {
      _audioDuration = event.audio.duration;
      setState(() {});
    }
  });

  void listenForCurrentAudioPosition() => assetsAudioPlayer.currentPosition.listen((event) {
    if(mounted) {
      _currentPlayingDuration = event;
      setState(() {});
    }
  });

  void playOrPause() async {
    for (var i in AssetsAudioPlayer.allPlayers().values) {
      if(i.id != assetsAudioPlayer.id)
        i.pause();
    }
    if(isPlaying){
      await assetsAudioPlayer.pause();
    }else{
      await assetsAudioPlayer.play();
    }
  }

  void seek(double value) {
    _currentPlayingDuration = Duration(microseconds: value.toInt());
    assetsAudioPlayer.seek(_currentPlayingDuration!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: kAccentColor,
            ),
            onTap: playOrPause,
          ),
          SizedBox(width: 10),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                trackShape: _CustomTrackShape(),
                trackHeight: 8,
                activeTrackColor: kAccentColor.withOpacity(0.5),
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
              ),
              child: Slider(
                min: 0.0,
                max: _audioDuration == null ? 0.0 : _audioDuration!.inMicroseconds.toDouble(),
                value: _currentPlayingDuration == null ? 0.0 : _currentPlayingDuration!.inMicroseconds.toDouble(),
                onChanged: _audioDuration == null ? null : seek,
                thumbColor: kAccentColor,
                inactiveColor: Colors.grey,
              ),
            ),
          ),
          SizedBox(width: 10),
          if(_audioDuration != null)
            Text(
              getDuration,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: !widget.isMe ? kBlackColor : kAccentColor
              ),
            ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  String get getDuration => isPlaying ?
  '${_currentPlayingDuration?.inMinutes.toString().padLeft(2, '0')}:${_currentPlayingDuration?.inSeconds.toString().padLeft(2, '0')}' :
  '${_audioDuration?.inMinutes.toString().padLeft(2, '0')}:${_audioDuration?.inSeconds.toString().padLeft(2, '0')}';

// @override
// bool get wantKeepAlive => isPlaying || _currentPlayingDuration?.inSeconds != 0;
}

class _CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}