import 'package:chatapp/Widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy(
              'createdAt',
              descending: true,
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            reverse: true,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, i) => Container(
              padding: EdgeInsets.all(8),
              child: MessageBubble(
                snapshot.data.docs[i]['text'],
                snapshot.data.docs[i]['userid'] ==
                    FirebaseAuth.instance.currentUser.uid,
                snapshot.data.docs[i]['userimage'],
                snapshot.data.docs[i]['username'],
              ),
            ),
          );
        });
  }
}
