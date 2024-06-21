import 'dart:io';


import 'package:clip_it/constants.dart';
import 'package:clip_it/controller/upload_video_controller.dart';
import 'package:clip_it/model/video.dart';
import 'package:clip_it/view/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class addCaptionScreen extends StatefulWidget {

  File videoFile;
  String videoPath;
  addCaptionScreen({super.key,required this.videoFile,required this.videoPath});


  @override
  State<addCaptionScreen> createState() => _addCaptionScreenState();
}

class _addCaptionScreenState extends State<addCaptionScreen>
{

  late VideoPlayerController videoPlayerController;

  VideoUploadController videoUploadController = Get.put(VideoUploadController());

  TextEditingController songNameController = new TextEditingController();
  TextEditingController captionController = new TextEditingController();

  Widget UploadContent = Text("Upload");
  uploadVid()
  {
    UploadContent = Text("Please Wait");
    setState(() {

    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.videoFile);

    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);


  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: VideoPlayer(videoPlayerController),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextInputField(
                      controller: songNameController,
                      myIcon: Icons.music_note,
                      myLabelText: "Song Name"),
                  SizedBox(height: 20,),
                  TextInputField(
                      controller: captionController,
                      myIcon: Icons.closed_caption,
                      myLabelText: "Caption"),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    

                      onPressed: (){
                        uploadVid();
                        videoUploadController.uploadVideo(songNameController.text, captionController.text, widget.videoPath);
                      },
                      child: UploadContent,style: ElevatedButton.styleFrom(backgroundColor: buttonColor),),
                ],
        
              ),
            )
          ],
        ),
      ),
    );
  }
}
