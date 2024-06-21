import 'package:flutter/material.dart';
class Profilebutton extends StatelessWidget {
  Profilebutton({super.key,required this.profilePhotoUrl});
  String profilePhotoUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: Stack(
        children: [
          Positioned(
              left: 5,
              child: Container(
            width: 60,
            height: 60,
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image(image: NetworkImage(profilePhotoUrl),
              //Image(image: NetworkImage('https://images.unsplash.com/photo-1546881963-ac8d67aee789?q=80&w=1958&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),

                  fit:BoxFit.cover),

            ),
          ))
        ],
      ),
    );
  }
}
