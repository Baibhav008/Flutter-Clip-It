import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String username;
  String comment;
  final datePub;
  List likes;
  String profilePic;
  String uid;
  String id;

  Comment(
      {required this.username,
      required this.comment,
      required this.datePub,
      required this.likes,
      required this.profilePic,
      required this.uid,
      required this.id});

  Map<String,dynamic> toJson ()
  {
    return {
      "username":username,
      "comment":comment,
      "datePub" : datePub,
      "likes" : likes,
      "profilePic":profilePic,
      "uid":uid,
      "id":id
    };
  }

  static Comment fromSnap(DocumentSnapshot snap)
  {
    var snapShot =  snap.data() as Map<String,dynamic>;
    return Comment(
        username: snapShot["username"],
        comment: snapShot["comment"],
        datePub: snapShot["datePub"],
        likes: snapShot["likes"],
        profilePic: snapShot["profilePic"],
        uid: snapShot["uid"],
        id: snapShot["id"],

    );

  }

}