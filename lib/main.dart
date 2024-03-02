import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/pages/home_page.dart';
import 'package:untitled1/oauth.dart';
import 'package:untitled1/token.dart';




void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TokenProvider>(
          create: (_) => TokenProvider(),
        ),
        // Add more providers if needed
      ],
      child: MyApp(),
    ),
  );
}
  class MyApp extends StatelessWidget {
    const MyApp({Key? key}): super(key: key);

    @override
    Widget build(BuildContext context){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  OAuth(),
      );
    }
  }
