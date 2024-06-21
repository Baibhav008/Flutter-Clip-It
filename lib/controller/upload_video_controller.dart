import 'dart:io';

import 'package:clip_it/model/video.dart';
import 'package:clip_it/view/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';


class VideoUploadController extends GetxController
{
  static VideoUploadController instance = Get.find();
  var uuid = Uuid();


  uploadVideo(String songName , String caption,String videoPath) async
  {
    try{
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("users").doc(uid).get();
      //Video ID - uid
      String id = uuid.v1();
      String videoUrl= await _uploadVideoToStorage(id , videoPath);

      String thumbnail =await _uploadVideoThumbToStorage(id,videoPath);
      print((userDoc.data()! as Map<String , dynamic>).toString());

      Video video = Video
        (
          username: (userDoc.data()! as Map<String , dynamic>)['name'],
          uid: uid,
          id: id,
          likes: [],
          commentCount:0,
          shareCount: 0,
          songName: songName,
          caption: caption,
          videoUrl: videoUrl,
          thumbnail: thumbnail,
          profilePic: (userDoc.data()! as Map<String , dynamic>)['profilePic']);

      await FirebaseFirestore.instance.collection("videos").doc(id).set(video.toJson());
      Get.snackbar("Video Uploaded Successfully", "Go ahead");
      Get.to(HomeScreen());
    }
    catch(e)
    {
      Get.snackbar("Error", e.toString());
      print("Hello " +e.toString());
    }

  }

  Future<String> _uploadVideoToStorage(String videoID,String videoPath) async
  {
    Reference reference = FirebaseStorage.instance.ref().child("videos").child(videoID);
    UploadTask uploadTask = reference.putFile(await _compressVideo(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  _compressVideo(String videoPath) async
  {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;

  }

  Future<String> _uploadVideoThumbToStorage(String id,String videoPath) async
  {
    Reference reference = FirebaseStorage.instance.ref().child("thumbnail").child(id);
    UploadTask uploadTask = reference.putFile(await _getThumb(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;

  }

 Future<File> _getThumb(String videoPath) async
  {
    final thumbnail  = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }









}