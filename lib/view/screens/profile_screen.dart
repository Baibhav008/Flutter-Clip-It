import 'package:cached_network_image/cached_network_image.dart';
import 'package:clip_it/controller/auth_controller.dart';
import 'package:clip_it/controller/profile_controller.dart';
import 'package:clip_it/view/screens/display_screen.dart';
import 'package:clip_it/view/widgets/glitch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {

  String uid;


  ProfileScreen({super.key,required this.uid});


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("uidddddddddddddd"+widget.uid.toString());
    profileController.updateUserId(widget.uid);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GlithEffect(child: Text("Clip It",style: TextStyle(fontSize: 32,fontWeight: FontWeight.w900,fontFamily: GoogleFonts.macondo().fontFamily))),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Get.snackbar("Clip It v1.0", "Thanks for using");
          }, icon: Icon(Icons.info))
        ],

      ),

      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return controller.user.isEmpty? Center(
            child: CircularProgressIndicator(),
          ): SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: controller.user['profilePic'],
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                          placeholder: (context,url)=>CircularProgressIndicator(),
                          errorWidget: (context,url,error)=>Icon(Icons.error) ,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                Container(child: Text(controller.user['name'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(controller.user['followers'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                          Text("Followers",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400))
                        ],
                      ),
                      SizedBox(width: 25,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(controller.user['following'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                          Text("Following",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400))
                        ],
                      ),
                      SizedBox(width: 25,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(controller.user['likes'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                          Text("Likes",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400))
                        ],
                      ),
                    ],
                  ),
          
                  SizedBox(height: 28,),
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12
                      )
                    ),
                    child:Container(

                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.lightBlueAccent,
                          width: 0.8
                        ),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: (){
                            if(widget.uid == FirebaseAuth.instance.currentUser!.uid)
                              {
                                authController.signOut();
                              }
                            else
                              {
                                controller.followUser();

                              }
                          },
                            child: Text(widget.uid == FirebaseAuth.instance.currentUser!.uid ?
                            "Sign Out" :
                                controller.user['isFollowing'] ?"Following":"Follow",style: TextStyle(fontSize: 16),

                            )),
                      ),
                    ) ,
                  ),
                  SizedBox(height: 20,),
                  Divider(indent: 28,endIndent: 28,thickness:2 ,),
                  SizedBox(height: 50,),

                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 5
                  ),
                      itemCount: controller.user["thumbnails"].length,
                      itemBuilder: (context,index){
                      String thumbnail = controller.user["thumbnails"][index];
                      return
                    Container(
                      margin: EdgeInsets.only(top: 1,bottom: 3),
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(

                        color: Colors.white,
                        gradient: LinearGradient(colors: [Colors.black,Colors.lightBlueAccent])
                      ),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayVideoScreen()));
                        },
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: thumbnail,
                          placeholder: (context,url)=>CircularProgressIndicator(),
                          errorWidget: (context,url,error)=>Icon(Icons.error) ,
                        
                        ),
                      ),
                    );
                  })
          

          
          
          
                ],
          
              ),
            ),
          );
        }
      ),
    );
  }
}
