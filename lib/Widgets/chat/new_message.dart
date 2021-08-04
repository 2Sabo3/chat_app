import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var message = '';
  final controller = new TextEditingController();

  void sendmessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userdata = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add(
      {
        'text': message,
        'createdAt': DateTime.now(),
        'userid': user.uid,
        'username': userdata['username'],
        'userimage': userdata['image_url'],
      },
    );
  }

  @override
  void initState() {
    controller.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
              ),
              controller: controller,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                labelText: 'Send a message.....',
              ),
              onChanged: (value) {
                setState(() {
                  message = value;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.green,
            ),
            onPressed: message.trim().isEmpty ? null : sendmessage,
          ),
        ],
      ),
    );
  }
}
