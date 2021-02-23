import 'package:chat_room/component/components.dart';
import 'package:chat_room/constents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// this is the ChatScreen
/// the ChatScreen Displays Text Messages to the screen
/// the text messages are Stored in Firebase Collection
/// user also send message to the collection

class ChatScreen extends StatelessWidget {
  static const String id = 'chatScreen';

  @override
  Widget build(BuildContext context) {
    /// signOut method for user signOut
    /// and pop the back of the Screen
    signOut() {
      FirebaseAuth.instance.signOut();
      Navigator.pop(context);
    }

    return Scaffold(
      /// this is ChatScreenAppBar AppBar Comes from ScaffoldAppBar class ScaffoldAppBar declared in Components.dart file
      appBar: ScaffoldAppBar(appbarID: id).appBar(onPressed: signOut),

      /// this is ChatScreen body ChatBody is declared bellow
      body: ChatBody(),
    );
  }
}

/// ChatBody//
class ChatBody extends StatefulWidget {
  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  TextEditingController controller = TextEditingController();

  /// this is Collection Reference of our message database in Firebase Firestore
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  String messageText;

  @override
  Widget build(BuildContext context) {
    /// << getUserName >> method return current name of the user
    String userName = getUserName();

    /// this line ordered message list according to 'dateTime' field in collection
    var snapshots = messages
        .where('dateTime')
        .orderBy('dateTime', descending: false)
        .snapshots();

    return Container(
      /// this Container Contain whole body of the screen
      color: Colors.black12,
      child: Column(
        children: [
          Expanded(
            child: Container(
                child: StreamBuilder<QuerySnapshot>(
              /// StreamBuilder takes a Future and prossed its value
              /// and build a new widget
              /// the future value are used in new build widgets
              /// in this case the Text message And name of the Sender are future value coming form firebase
              stream: snapshots,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Somthing went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Waiting');
                }
                var maessages = snapshot.data.docs.reversed;

                return Material(
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      reverse: true,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: maessages.map((DocumentSnapshot document) {
                        String messageText = document.data()['messageText'];
                        String sender = document.data()['sender'];
                        bool itsMe = false;
                        itsMe = sender == userName ?? true;
                        return Column(
                          crossAxisAlignment: itsMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$sender',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            MessageBubble(
                              messageText: messageText,
                              itsMe: itsMe,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            )),
          ),
          Container(
            /// this container Contain TextField and FlatButton
            /// TextField for take input and store value to variable
            /// and Button use for send new message in database
            color: Colors.black12,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: (value) => messageText = value,
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: 'Messages'),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    sendMessage(userName);
                  },
                  child: Text('Send'),
                ),
              ],
            ),
          ),
          Container(
            height: 5,
            color: Colors.black12,
          )
        ],
      ),
    );
  }

  /// this method return current user's User name
  String getUserName() {
    FirebaseAuth _auth = FirebaseAuth.instance;
    var userName = _auth.currentUser.email;
    print('<<<<<<<$userName>>>');
    return userName;
  }

  /// this method send new message to the database
  Future<void> sendMessage(String sender) {
    int dateTime = Timestamp.now().microsecondsSinceEpoch;
    return messages.add({
      'messageText': messageText,
      'sender': sender,
      'dateTime': dateTime
    }).then((value) {
      print('message Added');
      controller.clear();
    }).catchError(
      (onError) => print('Field to add message: $onError'),
    );
  }
}

/// MessageBubble
/// MessageBubble is a WidGet for laying out message in the bubble
/// the whole widget is for laying out message style in Screen
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key key,
    @required this.messageText,
    @required this.itsMe,
  }) : super(key: key);

  final String messageText;
  final bool itsMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: itsMe
            ? BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              )
            : BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
        elevation: 5.0,
        color: itsMe ? Colors.lightBlueAccent : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            '$messageText',
            style: TextStyle(
              color: itsMe ? Colors.white : Colors.black54,
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}
