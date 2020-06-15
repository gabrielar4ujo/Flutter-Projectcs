import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {

  ChatMessage(this.data, this._userUid);

  final Map<String, dynamic> data;
  final String _userUid;

  @override
  Widget build(BuildContext context) {
    bool _mine = _userUid == data["uid"];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      child: Row(
        children: <Widget>[
          !_mine ?
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: NetworkImage(data["photoUrl"]),
            ),
          ) : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment : !_mine ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: <Widget>[
                data["imageUrl"] != null ?
                Image.network(data["imageUrl"], width: 250,)
                    :
                Padding(
                  padding: _mine ? EdgeInsets.only(left: 45) : EdgeInsets.only(right: 45),
                  child: Text(data["text"],
                      textAlign: _mine ? TextAlign.left : TextAlign.right,
                      style: TextStyle(fontSize: 16)),
                ),
                Text(
                  data["senderName"],
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          ),
          _mine ?
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: CircleAvatar(
              backgroundImage: NetworkImage(data["photoUrl"]),
            ),
          ) : Container(),
        ],
      ),
    );
  }
}
