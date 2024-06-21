import 'package:clip_it/controller/auth_controller.dart';
import 'package:clip_it/view/screens/auth/login_screen.dart';
import 'package:clip_it/view/widgets/glitch.dart';
import 'package:clip_it/view/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';


class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _setpasswordController = new TextEditingController();
  TextEditingController _confirmpasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlithEffect(child:  Text("Join ClipIt",style: TextStyle(fontSize: 32,fontWeight: FontWeight.w900,fontFamily: GoogleFonts.macondo().fontFamily),)),
              SizedBox(height: 25,),
              InkWell(
                onTap: (){
                  AuthController.instance.pickImage();

                },
                child: Stack(
                  children: [
                  CircleAvatar(backgroundImage: NetworkImage("https://images.squarespace-cdn.com/content/v1/54b7b93ce4b0a3e130d5d232/1519987020970-8IQ7F6Z61LLBCX85A65S/icon.png?format=1000w"),radius: 64,),
                    Positioned(
                      bottom: 0,
                        right: 0,
                
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration:
                          BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                          color: Colors.white)
                            ,
                            child: Icon(Icons.edit,size: 28,color: Colors.black,)))
                ],),
              ),
              SizedBox(height: 25,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                    controller: _emailController,
                    myIcon: Icons.email,
                    myLabelText: "Email"),
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _setpasswordController,
                  myIcon: Icons.lock,
                  myLabelText: "Set Password",
                  toHide: true,),
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _confirmpasswordController,
                  myIcon: Icons.lock,
                  myLabelText: "Confirm Password",
                  toHide: true,),
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                    controller: _usernameController,
                    myIcon: Icons.person,
                    myLabelText: "Username"),
              ),
              SizedBox(height: 28,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 48,vertical: 10),
                child:
                ElevatedButton(
                    onPressed: (){
                      AuthController.instance.SignUp(_usernameController.text, _emailController.text, _setpasswordController.text, AuthController.instance.proimg);

                    },
                    child: Text("Sign Up",style: TextStyle(fontSize: 24,color: Colors.white,),)),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 48,vertical: 10),
                child:
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    },
                    child: GlithEffect(child: Text("Existing user ? Login",style: TextStyle(fontSize: 24,color: Colors.white,),))),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
