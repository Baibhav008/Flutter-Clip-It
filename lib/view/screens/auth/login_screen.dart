import 'package:clip_it/controller/auth_controller.dart';
import 'package:clip_it/view/widgets/glitch.dart';
import 'package:clip_it/view/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlithEffect(child:  Text("Welcome to ClipIt",style: TextStyle(fontSize: 32,fontWeight: FontWeight.w900,fontFamily: GoogleFonts.macondo().fontFamily),)),
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
                  controller: _passwordController,
                  myIcon: Icons.lock,
                  myLabelText: "Password",
              toHide: true,),
            ),
            SizedBox(height: 28,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 48,vertical: 10),
              child:
              ElevatedButton(
                  onPressed: (){
                    AuthController.instance.login(_emailController.text, _passwordController.text);
                  },
                  child: Text("Login")),
            )
          ],
        ),
      ),
    );
  }
}
