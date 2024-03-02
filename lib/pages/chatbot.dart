import 'dart:convert';
import 'package:untitled1/token.dart';// Add this import statement

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(Chatbot());
}

class Chatbot extends StatefulWidget {
  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  bool _isDarkMode = false;
  final List<Message> _messages = [];
  bool _isloding = false;
  final TextEditingController _textController = TextEditingController();


  void sendMessage(String message)async{
    // URL for the POST request
    var url = Uri.parse('http://localhost:8080/ai/chat/');

    // Your authentication token
    var authToken = TokenProvider().token;
    print(authToken);
    // Request body
    var requestBody = {'prompt': message};

    try {
      setState(() {
        _isloding = true;
      });
      // Make the POST request
      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $authToken', // Your auth header
          'Content-Type': 'application/json; charset=UTF-8', //
          // Specify the content type
        },
        body: jsonEncode(requestBody), // JSON encoded body
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        setState(() {
          _isloding = false;
          _messages.insert(0, Message(text: response.body, isSentByUser: false));
        });

        // Request was successful
      } else {
        // Request failed with error code and message
        print('Request failed with status: ${response.statusCode}');
        print('Error message: ${response.body}');
        print('Error: ${response.statusCode}');
        setState(() {
          _isloding = false;
          _messages.insert(0, Message(text: "Sorry", isSentByUser: false));
        });

      }
    } catch (e) {
      // An error occurred
      print('Error: $e');
      setState(() {
        _isloding = false;
        _messages.insert(0, Message(text: "Sorry", isSentByUser: false));
      });

    }
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.insert(0, Message(text: text, isSentByUser: true));
    });

    sendMessage(text);

  }



  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration:
              const InputDecoration.collapsed(hintText: "Type your message"),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.teal,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Missanger"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: _isDarkMode ? Colors.grey[800] : Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  reverse: true,
                  itemCount: _messages.length,
                  itemBuilder: (BuildContext context, int index) {
                      if (_isloding && index == 0) {
                      return Align(
                          alignment:  Alignment.centerLeft,
                          child: Container(
                          padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                    decoration: BoxDecoration(
                    color:  Colors.blue, // Customized bubble colors
                    borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    )
                    );
                      } else {
                      return  _buildMessageBubble(_messages[index]);
                      }
                  },
                ),
              ),
              const Divider(height: 1.0),
              _buildTextComposer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    return Align(
      alignment: message.isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
        decoration: BoxDecoration(
          color: message.isSentByUser ? Colors.teal : Colors.blue, // Customized bubble colors
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          message.text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose(); // Dispose text controller
    super.dispose();
  }
}

class Message {
  final String text;
  final bool isSentByUser;

  Message({required this.text, required this.isSentByUser});
}
