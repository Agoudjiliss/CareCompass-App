import 'package:flutter/material.dart';
import 'package:untitled1/util/emoticon_face.dart';
import 'package:http/http.dart' as http;



import '../widgets/calendar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 late TextEditingController _searchController ;
 @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [ //greetings row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //hi salah
                        Column(
                          children: [
                            Text("Hi Salah",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8,),
                            Text("02 mars 2024",style: TextStyle(color: Colors.blue[100]),
                            ),
                          ],
                        ),

                        Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[600],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.all(12),
                            child: Icon(Icons.notifications,
                              color: Colors.white,)
                          //notification
                        ),
                      ],),// search bar
                    SizedBox(height: 25,),
                    TextField(
                      onSubmitted: (value){
                        // _searchController.text = value;
                        print(_searchController.text);
                      },
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.search, color: Colors.white,),
                        filled: true,
                        fillColor: Colors.blue[600],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: Colors.blue[600],
                    //     borderRadius: BorderRadius.circular(12),
                    //
                    //   ),
                    //   padding: EdgeInsets.all(12),
                    //   child: Row(children: [
                    //     Icon(Icons.search, color: Colors.white,),
                    //     SizedBox(width: 5,),
                    //     Text("Search",
                    //       style: TextStyle(color: Colors.white),),
                    //   ],),),
                    SizedBox(height: 25,),
                    //How do you feel ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("How do you feel ?",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
                        Icon(Icons.more_horiz, color: Colors.white,),
                      ],
                    ),
                    SizedBox(height: 25,),
                    // 4 different faces
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [

                        //bad
                        Column(
                          children: [
                            EmoticonFace(
                              emotioconFace: "😞",
                            ),
                            SizedBox(height: 8,),
                            Text("Bad",style: TextStyle(color: Colors.white),),
                          ],
                        ),
                        //fine
                        Column(
                          children: [
                            EmoticonFace(
                              emotioconFace: "😐",
                            ),
                            SizedBox(height: 8,),
                            Text("fine",style: TextStyle(color: Colors.white),),
                          ],
                        ),

                        //well
                        Column(
                          children: [
                            EmoticonFace(
                              emotioconFace: "😊",
                            ),
                            SizedBox(height: 8,),
                            Text("well",style: TextStyle(color: Colors.white),),
                          ],
                        ),

                        //excellent
                        Column(
                          children: [
                            EmoticonFace(
                              emotioconFace: "😍",
                            ),
                            SizedBox(height: 8,),
                            Text("excellent",style: TextStyle(color: Colors.white),),
                          ],
                        ),


                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10
                ,),
              Column(
                children: [
                  Container(

                    padding: EdgeInsets.all(25),
                    color: Colors.grey[100],
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Your Progress',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                          Icon(Icons.more_horiz),
                        ],
                      ),
                      Calender()

                    ],),


                  ),
                ],
              ),
            ]),

      ),
    );
  }
}
