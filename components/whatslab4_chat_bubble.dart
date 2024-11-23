import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class Whatslab4ChatBubble extends StatefulWidget {
  final String senderName;
  final String content;
  final DateTime date;
  final BubbleType bubbleType;

  Whatslab4ChatBubble({
    Key? key,
    required this.senderName,
    required this.content,
    required this.date,
    required this.bubbleType,
  }) : super(key: key);

  @override
  _Whatslab4ChatBubbleState createState() => _Whatslab4ChatBubbleState();
}

class _Whatslab4ChatBubbleState extends State<Whatslab4ChatBubble> {
  int? maxLines = 10; // maxLines'ı burada tanımlıyoruz

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper1(type: widget.bubbleType),
      alignment: widget.bubbleType == BubbleType.sendBubble ? Alignment.topRight : Alignment.topLeft,
      margin: EdgeInsets.only(top: 20),
      backGroundColor: Colors.blue.withOpacity(0.9),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.senderName,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.greenAccent),
              ),
              Text(
                widget.content,
                textAlign: TextAlign.start,
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                widget.date.toIso8601String(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
            ],
          ),
          onTap: () {
            setState(() {
              // maxLines'ı değiştiriyoruz
              maxLines = (maxLines == 10) ? null : 10;
            });
          },
        ),
      ),
    );
  }
}
