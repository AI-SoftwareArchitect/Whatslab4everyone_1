import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  SocketService(String url) {
    socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.onConnect((_) {
      print('Bağlandı');
    });

    socket.onDisconnect((_) {
      print('Bağlantı kapandı');
    });

    socket.onError((data) {
      print('Hata: $data');
    });
  }

  void register(String userId) {
    socket.emit('register', userId);
  }

  void connect() {
    socket.connect();
  }

  void disconnect() {
    socket.disconnect();
  }

  void sendMessage(String event, dynamic data) {
    socket.emit(event, data);
  }

  void onMessage(String event, Function(dynamic) callback) {
    socket.on(event, callback);
  }

  void dispose() {
    socket.dispose();
  }
}
