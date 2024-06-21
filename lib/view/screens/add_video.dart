import 'dart:io';

import 'package:clip_it/constants.dart';
import 'package:clip_it/view/addcaption_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class addVideoScreen extends StatelessWidget {
  const addVideoScreen({super.key});

  videoPick(ImageSource src,BuildContext context)async
  {
    final video = await ImagePicker().pickVideo(source: src);
    if(video!=null)
      {
        Get.snackbar("Video Selected", video.path);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>addCaptionScreen(videoFile: File(video.path), videoPath: video.path)));
      }
    else
      {
        Get.snackbar("Error", "Please select different video");
      }
  }

  showDialogOpt(BuildContext context)
  {
    return showDialog(context: context, builder: (context)=>
        SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: ()=>videoPick(ImageSource.gallery,context),
              child: Text("Gallery")
            ),
            SimpleDialogOption(
                onPressed: ()=>videoPick(ImageSource.camera,context),
                child: Text("Camera")
            ),
            SimpleDialogOption(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("Close")
            ),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: ()=>showDialogOpt(context),
          child: Container(
            width: 180,
            height: 50,
            decoration: BoxDecoration(
              color: buttonColor
            ),
            child: Center(child: Text("Upload Video",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)),
          ),
        ),
      ),
    );
  }
}
