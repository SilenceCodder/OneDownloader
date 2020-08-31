import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StatusVideoWidget extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final String videoSrc;
  final double aspectRatio;

  StatusVideoWidget({@required this.videoPlayerController, this.looping, this.videoSrc, this.aspectRatio, Key key}) : super(key: key);

  @override
  _StatusVideoWidgetState createState() => _StatusVideoWidgetState();
}

class _StatusVideoWidgetState extends State<StatusVideoWidget> {
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        autoInitialize: true,
        looping: widget.looping,
        allowFullScreen: true,
        aspectRatio: 3 / 2,
        // autoPlay: true,
        errorBuilder: (context, errorMessage) => Center(child: Text(errorMessage)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Container(padding: EdgeInsets.only(top: 0), 
          child: Hero(tag: widget.videoSrc, child: Chewie(controller: _chewieController)))
        ]));
  }

  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
