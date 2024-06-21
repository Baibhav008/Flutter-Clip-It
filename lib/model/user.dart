
import 'package:cloud_firestore/cloud_firestore.dart';
class myUser
{
  String name;
  String profilePhoto;
  String email;
  String uid;

  myUser({required this.name, required this.profilePhoto, required this.email, required this.uid});

  Map<String,dynamic> toJson ()
  {
    return {
      "name":name,
      "profilePic":profilePhoto,
      "email" : email,
      "uid" : uid
    };
  }

  static myUser fromSnap(DocumentSnapshot snap)
  {
    var snapshot= snap.data() as Map<String,dynamic>;
    return myUser(name: snapshot['name'], profilePhoto: snapshot['profilePic'], email: snapshot['email'], uid: snapshot['uid']);


  }

}