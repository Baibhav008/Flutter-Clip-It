import 'dart:io';
import 'package:clip_it/view/screens/auth/login_screen.dart';
import 'package:clip_it/view/screens/auth/signup_screen.dart';
import 'package:clip_it/view/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../model/user.dart';

class AuthController extends GetxController
{
  static AuthController instance = Get.find();

  File? proimg;

  void pickImage() async{
    print("IMAGE PICKED SUCCESSFULLY");
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
// if(image == null) return;

    final img = File(image!.path);
    this.proimg = img;

  }


  // REGISTERING USER -----------------------------------------------------------------
  void SignUp(String username, String email, String password , File? image) async
  {
    try{
      if(username.isNotEmpty&&email.isNotEmpty&&password.isNotEmpty&&image!=null)
        {
          UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
          String downloadUrl = await _uploadProPic(image);

          myUser user = myUser(name: username, profilePhoto: downloadUrl , email: email, uid: credential.user!.uid);
          await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).set(user.toJson());
        }
      else
        {
          Get.snackbar("Error Creating Account", "Please fill all the fields");
        }

    }catch(e)
    {
      print(e.toString());
      Get.snackbar("Error Occurred", e.toString());
    }
  }


  // LOGIN USER

  void login(String email, String password) async
  {
    try{
      if(email.isNotEmpty && password.isNotEmpty)
      {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      }
      else
      {
        Get.snackbar("Error Logging In", "Please Enter all Fields");
      }
    }catch(e){
      Get.snackbar("Error Logging In", e.toString());
    }



  }

  signOut()
  {
    FirebaseAuth.instance.signOut();
    Get.offAll(LoginScreen());
  }

  //User state Persistence
  late Rx<User?> _user;
  User get user =>_user.value!;
  @override
  void onReady()
  {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser); // Continuously check if the user is changing or not, its an observable keyword
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialView);
  }
  _setInitialView(User? user)
  {
    if(user==null)
      {
        Get.offAll(()=>SignUpScreen());
      }
    else
      {
        Get.offAll(()=>HomeScreen());
      }
  }



}



Future<String> _uploadProPic (File image) async    // UPLOADING IMAGE
{
  Reference reference = FirebaseStorage.instance.ref().child('profilePics').child(FirebaseAuth.instance.currentUser!.uid);
  UploadTask uploadTask = reference.putFile(image);

  TaskSnapshot snapshot = await uploadTask;
  String imageDwnUrl = await snapshot.ref.getDownloadURL();
  return imageDwnUrl;
}



