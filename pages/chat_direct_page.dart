import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatslab4everyone_1/components/whatslab4_chat_bubble.dart';
import 'package:whatslab4everyone_1/models/direct_message_model.dart';
import 'package:whatslab4everyone_1/providers/current_user_provider.dart';
import 'package:whatslab4everyone_1/services/direct_message_local_save_service.dart';
import 'package:whatslab4everyone_1/services/socket_service.dart';

class ChatDirectPage extends ConsumerStatefulWidget {
  String name;
  String contactUUID;
  String imageName;
  String backgroundImageName;

  ChatDirectPage({
    super.key,
    required this.name,
    required this.contactUUID,
    required this.imageName,
    required this.backgroundImageName,
  });

  @override
  ConsumerState<ChatDirectPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatDirectPage> {
  TextEditingController messageTextEditController = TextEditingController();
  StreamController streamController = StreamController();
  SocketService socketService = SocketService("http://10.0.2.2:3000/");
  List<Map<String, dynamic>> messages = [];



  @override
  void initState() {
    super.initState();
    socketService.connect(); // Bu satır eklenmeli

    _initializeChat();


    socketService.onMessage('chat', (data) {
      print("Received data: $data"); // Debugging line

      Map<String, String> formattedNewData = {
        'recipientId': data["recipientId"].toString(),
        'senderId': data["senderId"].toString(),
        'messageContent': data["messageContent"].toString(),
        'date': data["date"].toString(),
      };

      print("Formatted ${formattedNewData}");

      setState(() {
        messages.add(formattedNewData); // Adding formatted data to the messages list
      });
    });


  }

  @override
  void deactivate() async {
    print("deactivate");

    // await ile işlemin tamamlanmasını bekleyelim
    await Future.forEach(messages, (Map<String, dynamic> message) async {
      DirectMessage newDirectMessage = DirectMessage.fromJson({
        "senderName": widget.name,
        ...message
      });

      // create işlemi async ise await kullanın
      await DirectMessageService.create(newDirectMessage);
      print("Sender name: ${newDirectMessage.senderName}");
    });

    // Socket bağlantısını kapatalım
    socketService.disconnect();

    super.deactivate();
  }


  @override
  void dispose() {
    streamController.close();
    socketService.dispose(); // Eğer SocketService'de bir dispose metodu varsa
    super.dispose();
  }

  Future<void> _initializeChat() async {
    await _loadLocalMessages();
  }

  Future<void> _loadLocalMessages() async {
    List<DirectMessage> directMessages = await DirectMessageService.readAll();
    List<Map<String, dynamic>> loadedMessages = directMessages.map((dMessage) {
      return {
        'recipientId': widget.contactUUID,
        'senderId': dMessage.contactUuid,
        'messageContent': dMessage.content,
        'date': dMessage.date.toIso8601String(),
      };
    }).toList();

    setState(() {
      messages = loadedMessages; // Tüm mesajları bir defada güncelle
    });
  }

  void sendMessage(String message, String senderId, String recipientId) {
    final data = {
      'recipientId': recipientId,
      'senderId': senderId,
      'messageContent': message,
      'date': DateTime.now().toIso8601String()
    };
    socketService.sendMessage('chat', data);
    setState(() {
      messages.add(data);
    });
  }


  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProviderProvider);
    socketService.register(currentUser.id); // Kullanıcı ID'sini kaydet

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.backgroundImageName),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            return Whatslab4ChatBubble(
              senderName: message["senderId"] == currentUser.id ? "You" : widget.name,
              content: message["messageContent"],
              date: DateTime.parse(message["date"]),
              bubbleType: message["senderId"] == currentUser.id
                  ? BubbleType.sendBubble
                  : BubbleType.receiverBubble,
            );
          },
        ),
/* add child content here */
      ),
      bottomSheet: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max, // Bu satırı ekleyin
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded( // TextField'ı saran Expanded widget'ı ekleyin
              child: Padding(
                padding: EdgeInsets.only(right: 20, top: 10, bottom: 5, left: 5),
                child: TextField(
                  controller: messageTextEditController,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                  ),
                  decoration: InputDecoration(
                    hintText: "Type your message",
                    hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(5),
              child: GestureDetector(
                child: Icon(Icons.attach_file,size: 32,color: Colors.white,),
                onTap: () {

                },
              )
            ,),
            Padding(padding: EdgeInsets.all(15),
              child: GestureDetector(
                child: Icon(Icons.send,size: 32,color: Colors.white,),
                onTap: () {
                  sendMessage(messageTextEditController.text, currentUser.id,widget.contactUUID);
                  messageTextEditController.clear();
                },
              )
              ,)

          ],
        ),
      ),
    );
  }
}
