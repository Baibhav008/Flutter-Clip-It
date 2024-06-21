import 'package:clip_it/controller/video_controller.dart';
import 'package:clip_it/view/screens/comment_screen.dart';
import 'package:clip_it/view/screens/profile_screen.dart';
import 'package:clip_it/view/widgets/AlbumRotator.dart';
import 'package:clip_it/view/widgets/ClipItVideoPlayer.dart';
import 'package:clip_it/view/widgets/ProfileButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';

class DisplayVideoScreen extends StatelessWidget {
   DisplayVideoScreen({super.key});

  final VideoController videoController=Get.put(VideoController());


   Future<void> share() async {
     await FlutterShare.share(
         title: 'Download Clip it to live it',
         text: 'Watch clips never seen before',

     );
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
          return PageView.builder(
            scrollDirection:Axis.vertical ,
              controller: PageController(initialPage: 0,viewportFraction: 1),
              itemCount: videoController.videoList.length,
              itemBuilder: (context,index){
              return InkWell(
                onDoubleTap: ()
                {videoController.likedVideo(videoController.videoList[index].id);},
                child: Stack(
                  children: [
                    Clipitvideoplayer(videoUrl: videoController.videoList[index].videoUrl),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 28,horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("@"+videoController.videoList[index].username,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                          Text(videoController.videoList[index].caption),
                          Text(videoController.videoList[index].songName,style:TextStyle(fontWeight: FontWeight.bold) ,),
                        ],
                      ),
                    ),

                    Positioned(
                      right: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height-380,
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.8,right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder:(context)=>ProfileScreen(uid: videoController.videoList[index].uid)));
                              },
                                child: Profilebutton(profilePhotoUrl:videoController.videoList[index].profilePic)),
                            InkWell(
                              onTap: (){
                                videoController.likedVideo(videoController.videoList[index].id);
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.favorite,size: 45,
                                    color:videoController.videoList[index].likes.contains(FirebaseAuth.instance.currentUser!.uid)? Color.fromARGB(200, 0, 150, 255,):Colors.white,),
                                  Text(videoController.videoList[index].likes.length.toString(),style: TextStyle(fontSize: 15,color: Colors.white),)
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: ()
                              {
                                share();
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.reply,size: 45,color: Colors.white,),
                                  //Text(videoController.videoList[index].shareCount.toString(),style: TextStyle(fontSize: 15,color: Colors.white),)
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>CommentScreen(id: videoController.videoList[index].id)));
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.comment,size: 45,color: Colors.white,),
                                  Text(videoController.videoList[index].commentCount.toString(),style: TextStyle(fontSize: 15,color: Colors.white),),
                                  SizedBox(height: 20,),
                                  AlbumRotator(profilePicUrl: videoController.videoList[index].profilePic.toString())
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
              });
        }
      ),
    );
  }
}
