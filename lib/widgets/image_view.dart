import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';
import '../core/router/router.dart';
import 'app_bar.dart';

class ImageView extends StatefulWidget {
  const ImageView({Key? key, required this.url}) : super(key: key);

  final String url;
  static void show(String url) => RouteManager.navigateTo(ImageView(url: url));

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  int rotation = 0;
  int boxFitIndex = 0;

  List<BoxFit> boxFit = [BoxFit.cover, BoxFit.fill, BoxFit.contain, BoxFit.fitHeight, BoxFit.fitWidth];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "صورة",
        actions: [
          IconButton(
            onPressed: () => setState(() => (boxFitIndex + 1 == boxFit.length) ? boxFitIndex = 0 : boxFitIndex++),
            icon: Icon(FontAwesomeIcons.image),
            color: kWhiteColor,
          ),
          IconButton(
            onPressed: () => setState(() => rotation++),
            icon: Icon(FontAwesomeIcons.undo),
            color: kWhiteColor,
          ),
        ]
      ),
      body: SizedBox(
        // alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: InteractiveViewer(
          child: RotatedBox(
            quarterTurns: rotation,
            child: Image.network(
              widget.url,
              fit: boxFit[boxFitIndex],
            ),
          ),
        ),
      ),
    );
  }
}
