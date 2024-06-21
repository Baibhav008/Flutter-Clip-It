import 'package:clip_it/model/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CommentController extends GetxController
{
  String _postID = "";
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;

  updatePostID(String id)
  {
    _postID = id;
    fetchComment();
  }

  postComment(String commentText) async
  {
    try{
      if(commentText.isNotEmpty)
      {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid.toString()).get();
        var allDocs = await FirebaseFirestore.instance.collection("videos").doc(_postID).collection("comments").get();
        int len = allDocs.docs.length;
        print(userDoc.data());
        Comment comment = Comment(
            username: (userDoc.data() as dynamic)['name'],
            comment: commentText.trim(),
            datePub: DateTime.now(),
            likes: [],
            profilePic: (userDoc.data() as dynamic)['profilePic'],
            uid: FirebaseAuth.instance.currentUser!.uid,
            id: 'Comment$len');

        await FirebaseFirestore.instance.collection("videos").doc(_postID).collection("comments").doc('Comment$len').set(comment.toJson());

        DocumentSnapshot doc = await FirebaseFirestore.instance.collection('videos').doc(_postID).get();
        print(doc);
        await FirebaseFirestore.instance.collection('videos').doc(_postID).update(
            {
              'commentCount' : (doc.data() as dynamic)['commentCount']+1
            });

      }
      else
        {
          Get.snackbar("Empty Comment","Write Something in comment");
        }
    }catch(e)
    {
      print("Errorrrrrrrrrrrrrrrrrr"+e.toString());
      Get.snackbar("Error in posting",e.toString());
    }

  }

  fetchComment()async
  {
    _comments.bindStream(FirebaseFirestore.instance.collection("videos")
        .doc(_postID).collection("comments")
        .snapshots().map((QuerySnapshot query)
    {
      List<Comment> retVal = [];
      for (var element in query.docs)
      {
        retVal.add(Comment.fromSnap(element));
      }
      return retVal;
    }
    ));

  }

  likeComment(String id) async
  {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection("videos").doc(_postID).collection('comments').doc(id).get();
    print((doc.data()! as dynamic)['id']);

    if((doc.data()! as dynamic)['likes'].contains(uid))
      {
        await FirebaseFirestore.instance.collection("videos")
            .doc(_postID).collection("comments").doc(id).update({
          'likes' : FieldValue.arrayRemove([uid])
        });
      }
    else
      {
        await FirebaseFirestore.instance.collection("videos")
            .doc(_postID).collection("comments").doc(id).update({
        'likes' : FieldValue.arrayUnion([uid])
        });
      }





  }



}