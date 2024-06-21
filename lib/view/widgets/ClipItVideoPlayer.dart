import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Clipitvideoplayer extends StatefulWidget {
  Clipitvideoplayer({Key? key , required this.videoUrl}) : super(key: key);
  String videoUrl;

  @override
  State<Clipitvideoplayer> createState() => _ClipitvideoplayerState();
}

class _ClipitvideoplayerState extends State<Clipitvideoplayer> {

  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        widget.videoUrl))..initialize().then((value){
      videoPlayerController.play();
      videoPlayerController.setLooping(true);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: VideoPlayer(videoPlayerController),

    );
  }
}
