import 'dart:async';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:whatslab4everyone_1/models/friend_request_model.dart';

class SocketManager {

  late IO.Socket socket;
  final streamControllerFriendRequest = StreamController<List<FriendRequest>>();
  List<FriendRequest> friendRequests = [];

  SocketManager() {

    String fakeUUID = "123456";

    socket = IO.io('http://10.0.2.2:3000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build()
    );
    socket.connect();

    socket.onConnect((_) {
        print('connect');
        socket.emit('register',fakeUUID);
    });

    socket.on('friendRequest' , (data) => _handleFriendRequestData(data));
    socket.on('acceptRequest' , (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
  }

  void _handleFriendRequestData(dynamic data) {
    // Gelen veriyi konsola yazdır
    print("Received data: $data");

    // Eğer data bir Map ise, doğrudan kullanabilirsiniz
    if (data is Map<String, dynamic>) {
      FriendRequest friendRequestData = FriendRequest.fromJson(data);
      friendRequests.add(friendRequestData);
      print(friendRequestData.senderUUID);
      print(friendRequestData.senderName);
      streamControllerFriendRequest.add(friendRequests);
      //socket.emit('accept', friendRequestData.senderUUID);
    } else if (data is String) {
      // Eğer data bir String ise, JSON çözümlemesi yapın
      try {
        Map<String, dynamic> jsonData = jsonDecode(data);
        FriendRequest friendRequestData = FriendRequest.fromJson(jsonData);
        friendRequests.add(friendRequestData);
        print(friendRequestData.senderUUID);
        print(friendRequestData.senderName);
        streamControllerFriendRequest.add(friendRequests);
        //socket.emit('accept', friendRequestData.senderUUID);
      } catch (e) {
        print("Error parsing JSON: $e");
      }
    } else {
      print("Unexpected data format: $data");
    }
  }



}


