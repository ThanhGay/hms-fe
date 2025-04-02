import 'package:android_hms/core/constants/api_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  late IO.Socket socket;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void connect(String conversationId) {
    socket = IO.io("${APIConstants.api}chatHub", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();

    socket.onConnect((_) {
      print("Connected to server");
      socket.emit(
          'JoinRoom', conversationId); // Tham gia phòng chat (cuộc hội thoại)
    });

    socket.on("ReceiveMessage", (data) {
      print("New message received: ${data}");
    });
  }

  void sendMessage(String conversationId, String sender, String message) async {
    if (message.isEmpty) return;

    await firestore
        .collection(conversationId)
        .doc("message_${DateTime.now().millisecondsSinceEpoch.toString()}")
        .set({
      'Sender': sender,
      'Message': message,
      'TimeStamp': FieldValue.serverTimestamp(), // Thời gian tạo tin nhắn
    });
  }

  Stream<List<Map<String, dynamic>>> getMessages(String conversationId) {
    return firestore
        .collection(conversationId)
        .orderBy("TimeStamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
