import 'package:clip_it/controller/searchuser_controller.dart';
import 'package:clip_it/model/user.dart';
import 'package:clip_it/view/screens/profile_screen.dart';
import 'package:clip_it/view/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({super.key});

  TextEditingController searchQuery = TextEditingController();
  final SearchUserController searchUserController = Get.put(SearchUserController());

  @override
  Widget build(BuildContext context) {
    return Obx((){
        return Scaffold(
          appBar: AppBar(
            title: TextFormField(
              decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15,bottom: 11,top: 11,right: 15),
                hintText: "Search User",
                icon: Icon(Icons.search)
              ),
              controller: searchQuery,
            onChanged: (value){
              searchUserController.searchUser(value);
            },),

          ),
          body:searchUserController.searchedUsers.isEmpty? Center(
            child: Text("Search Users"),
          ):
          ListView.builder(
            itemCount: searchUserController.searchedUsers.length,
              itemBuilder: (context,index){
              myUser user = searchUserController.searchedUsers[index];
              return Container(
                margin: EdgeInsets.only(top: 5,left: 10,right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blueAccent,
                  gradient: const LinearGradient(
                      colors: [Colors.lightBlueAccent,Colors.black12],
                  ),

                ),
                child: ListTile(
                  onTap: (){
                    Get.snackbar("${user.name} selected", "Opening Profile");
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(uid: user.uid)));
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.profilePhoto),
                  ),
                  title: Text(user.name,style: TextStyle(),),

                ));
              }),
        );
      }
    );
  }
}
