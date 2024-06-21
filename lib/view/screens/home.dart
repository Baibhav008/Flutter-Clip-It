import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:clip_it/constants.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../widgets/customAddIcon.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          /*
      BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        onTap: (index){
          setState(() {
            pageIdx=index;
            print(index);
          });

        },
        currentIndex: pageIdx,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
          label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: customAddIcon(),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile')
        ],
      ),

           */
      ConvexAppBar(
        style: TabStyle.reactCircle,
        color: Colors.white,

        activeColor: Colors.black,
        shadowColor: Colors.lightBlueAccent,
        gradient: const LinearGradient(
          colors: [Colors.lightBlueAccent,Colors.black12],
              begin: Alignment.topRight,
          end: Alignment.bottomRight
        ),
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.search, title: 'Search'),
          TabItem(icon: Icons.videocam_sharp, title: 'Add Video'),
          TabItem(icon: Icons.message, title: 'Messages'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        initialActiveIndex: pageIdx,
        onTap: (int i) => setState(() {
          pageIdx = i;
        }),
      ),

      body: Center(
        child: pageindex[pageIdx],
      ),
    );
  }
}
