import 'package:flutter/material.dart';

class EmoticonFace extends StatelessWidget {

  final String emotioconFace;

  const EmoticonFace({Key? key, required this.emotioconFace
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[600],
        borderRadius: BorderRadius.circular(12),),
      padding: EdgeInsets.all(12),
      child: Center(child: Text(emotioconFace, style: TextStyle(fontSize: 25),),) ,

    );
  }
}