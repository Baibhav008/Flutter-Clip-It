import 'dart:math';

import 'package:clip_it/view/screens/add_video.dart';
import 'package:clip_it/view/screens/display_screen.dart';
import 'package:clip_it/view/screens/profile_screen.dart';
import 'package:clip_it/view/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

getRandomColor() => [
  Colors.blueAccent,
  Colors.redAccent,
  Colors.greenAccent,
][Random().nextInt(3)];

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

var pageindex = [
  DisplayVideoScreen(),
  SearchScreen(),
  addVideoScreen(),
  Text('Comming Soon'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,)
];