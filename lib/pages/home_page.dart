import 'package:flutter/material.dart';
import 'package:untitled1/pages/chatbot.dart';

import 'package:untitled1/pages/setting.dart';
import 'package:untitled1/util/emoticon_face.dart';
import 'package:untitled1/pages/blog_function.dart';


import '../widgets/calendar.dart';
import 'home_screen.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            _index = index;
          });
        },

        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.blue,),label: "home",) ,
        BottomNavigationBarItem(icon: Icon(Icons.search, color: Colors.blue,),label: "search"),
        BottomNavigationBarItem(icon: Icon(Icons.chat, color: Colors.blue,),label: "chat"),
        BottomNavigationBarItem(icon: Icon(Icons.settings, color: Colors.blue,),label: "settings"),
      ],),
        body: screen[_index] );
  }
}

List<Widget> screen = [
  HomeScreen(),

  Chatbot(),
  SettingsScreen(),
];




