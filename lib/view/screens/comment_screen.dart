import 'package:clip_it/controller/comment_controller.dart';
import 'package:clip_it/view/widgets/text_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({required this.id});

  final TextEditingController _commentController = TextEditingController();
  CommentController commentController = Get.put(CommentController());


  @override
  Widget build(BuildContext context) {
    commentController.updatePostID(id);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                    return ListView.builder(
                      shrinkWrap: true,
                        itemCount: commentController.comments.length,
                        itemBuilder: (context, index)
                        {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                             backgroundImage: NetworkImage(commentController.comments[index].profilePic),
                            ),
                            title: Row(
                              children: [
                                Text(commentController.comments[index].username,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.blueAccent),),
                                SizedBox(width: 5,),
                                Text(commentController.comments[index].comment,style: TextStyle(fontSize: 14))],
                            ),
                            subtitle: Row(
                              children: [
                                Text(tago.format(commentController.comments[index].datePub.toDate()), style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                SizedBox(width: 5,),
                                Text(commentController.comments[index].likes.length.toString()+ " Likes",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),)],
                            ),
                            trailing: InkWell(
                              onTap: (){
                                commentController.likeComment(commentController.comments[index].id);
                              },
                                child: Icon(Icons.favorite,color: commentController.comments[index].likes.contains(FirebaseAuth.instance.currentUser!.uid) ? Colors.blueAccent : Colors.white,)),
                          );
                        });
                  }
                ),
              ),
              Divider(),
              ListTile(
                title: TextInputField(controller: _commentController,myIcon: Icons.comment,myLabelText: "Comment",),
                trailing: TextButton(
                  onPressed: (){
                    commentController.postComment(_commentController.text);

                  },
                  child: Text("Send"),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
